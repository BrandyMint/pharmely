module PharmaciesHelper
  def searchable_drugs_count pharmacy
    DrugsIndex.filter(term: { pharmacy_id: pharmacy.id }).total_count
  end

  def telephones tels
    tels.to_s.split(/,\s?/) do |tel|
      tel_to tel
    end.join(' ').html_safe
  end

  def photo_tag(pharmacy, name)
    image = pharmacy.send(name)
    link_to(image_tag(image), image.to_s) if image.present?
  end
end
