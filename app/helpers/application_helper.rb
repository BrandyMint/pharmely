module ApplicationHelper
  def pharmacy_tooltip_title drug
    [drug.attributes['pharmacy.title'], drug.attributes['pharmacy.city'], drug.attributes['pharmacy.address']].join(', ')
  end


  def total_drugs_count
    PharmacyIndex.filter{ match_all }.total_count
  end
end
