module PharmaciesHelper
  def searchable_drugs_count pharmacy
    DrugsIndex.filter(term: { pharmacy_id: pharmacy.id }).total_count
  end

  def telephones tels
    tels.to_s.split(/,\s?/) do |tel|
      tel_to tel
    end.join(' ').html_safe
  end
end
