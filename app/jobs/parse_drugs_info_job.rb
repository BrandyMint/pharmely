class ParseDrugsInfoJob < ActiveJob::Base

  #queue_as :default

  EAN_13 = 13

  def perform(*args)

    browser = get_phantomjs_browser

    return if !browser

    source_root = "http://www.wer.ru"
    source_base = "http://www.wer.ru/medicines/"
    links = []
    request_delay = args[0].to_i

    browser.goto source_base

    # проходимся по пагинации на распарсеной первой странице
    browser.nav(class: "pages").spans.each do |span|

      span.click

      # ждем загрузки контента
      browser.div(class: 'nano').when_dom_changed do |div|

        html = Nokogiri::HTML div.html

        # проходим по списку, собираем что нужно
        html.css('.list-products-cnt li').each do |li|

          title = li.css('.product_title').text
          next unless title.present?

          link = li.css('.name')[0]['href']
          next if links.include?(link)

          links << link
          puts "#{links.length}) найдена ссылка для #{title} - #{links.last}"

        end
      end

      sleep request_delay
    end

    #чистим таблицу
    DrugInfo.destroy_all

    # агент для захода на страницу
    agent = Mechanize.new

    # переходим по ссылкам, собираем данные и пишем в базу
    links.each do |link|

      page = get_link agent, link

      next unless page

      title = page.search('.product_name h1').text
      subtitle = page.search('.product_name span').text.strip
      title = title + subtitle

      producer = page.search('.producer dd').text.strip

      ean = page.search('.bottom_info dd:last').text.strip
      ean = ean.length == EAN_13 ? ean : ""

      picture_url = page.search('.bim img')[0].attributes['src'].value
      picture_url = source_root + picture_url if picture_url.present?
      info_html = page.parser.css('.wrap_tabs .info').inner_html().gsub(/(\n|\t|\r)/, ' ').gsub(/>\s*</, '><').squeeze(' ').strip.encode('UTF-8')


      DrugInfo.create(
          title: title,
          producer: producer,
          source: source_root,
          item_url:link,
          picture_url: picture_url,
          html_data: info_html,
          eans:[ean]
      )

      puts "добавлено - #{title}"

      sleep request_delay

    end

    puts "всего добавлено #{DrugInfo.all.count} записей"
  end

  def get_phantomjs_browser
    begin
      return Watir::Browser.new :phantomjs
    rescue Selenium::WebDriver::Error::WebDriverError
      puts "Selenium::WebDriver::Error::WebDriverError - проверьте наличие на сервере phantomjs"
      return false
    end

  end

  def get_link agent, link
    begin
      return agent.get link
    rescue Mechanize::ResponseCodeError
      puts "page not found url #{link}"
      return false
    end
  end

end

