module ApplicationHelper

  def drugs_count model
    return '' unless model.job.present?
    if model.job.status=='working'
      " (#{model.job.at} из #{model.job.total}) #{model.job.message}"
    else
      model.drugs_count
    end
  end

  def job_state model
    return 'не запущен' unless model.job.present?
     case model.job.status
     when 'working'
      "В процессе с&nbsp;#{human_time b.start_at}"
     when 'combete'
      ("Выполнен&nbsp;#{human_time b.finish_at}"+
       "<i>(#{distance_of_time_in_words b.finish_at, b.start_at rescue '-'})</i>").
      html_safe
     else
      b.job.status
     end
  end

  def price_list_row_html_class pl
    return 'danger' unless pl.job
    case pl.job.status
    when 'working'
      return 'info'
    when 'complete'
      return pl.errors_count.to_i>0 ?  'warning' : 'success'
    when 'queued'
      return 'active'
    when 'failed'
      return 'danger'
    else
      ''
    end
  end

  def human_time time
    l time, format: :short if time.present?
  end

  def sortable_column name, key
    key = key.to_s
    dsf = drugs_search_form.clone
    if drugs_search_form.sortable_column==key
      title = content_tag :b, name
      title << '&nbsp;'.html_safe
      order = dsf.order=='asc' ? '&uarr;' : '&darr;'
      title << order.html_safe
    else
      title = name
    end

    dsf.sortable_column = key
    dsf.order = dsf.order=='asc' ? 'desc' : 'asc'

    link_to title.html_safe, url_for( drugs_search_form: dsf.to_hash)
  end

  def pharmacy_tooltip_title drug
    [drug.attributes['pharmacy.title'], drug.attributes['pharmacy.city'], drug.attributes['pharmacy.address']].join(', ')
  end

  def format_money price
    number_to_currency price, precision: 2, locale: :ru, unit: 'руб.', separator: ",", format: "%n %u"
  end

  def app_title
    'Панацея'
  end

  def total_drugs_count
    PharmacyIndex.filter{ match_all }.total_count
  end

  def tel_to tel
    link_to tel, "tel:#{tel}"
  end
end
