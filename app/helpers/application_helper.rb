module ApplicationHelper
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
