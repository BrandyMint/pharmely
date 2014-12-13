module DrugsHelper
  EMPTY_CIRCLE = '&#9675;'
  BLACK_CIRCLE = '&#9679;'
  def stock_quantity drug
    if drug.stock_quantity.to_i==0
      #EMPTY_CIRCLE*3
      title = 'под заказ'
      tooltip = 'Нет в наличии, но можно заказать'
    elsif drug.stock_quantity.to_i>10
      title = BLACK_CIRCLE*3
      tooltip = 'Много'
    elsif drug.stock_quantity.to_i>5
      title = BLACK_CIRCLE+BLACK_CIRCLE+EMPTY_CIRCLE
      tooltip = 'Не много'
    elsif drug.stock_quantity.to_i>0
      title = BLACK_CIRCLE+EMPTY_CIRCLE*2
      tooltip = 'Мало'
    end
    content_tag :span, title.html_safe, title: tooltip, data: { toggle: :tooltip }
  end
end
