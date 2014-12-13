module PharmaciesHelper
  def telephones tels
    tels.to_s.split(/,\s?/) do |tel|
      tel_to tel
    end.join(' ').html_safe
  end
end
