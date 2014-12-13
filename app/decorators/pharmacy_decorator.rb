class PharmacyDecorator < Draper::Decorator
  delegate_all

  delegate :logo, to: :decorated_company

  def drugs_link
    h.link_to "#{drugs.count} позиций", h.pharmacy_url(source)
  end

  def decorated_company
    CompanyDecorator.decorate source.company
  end

  def telephones
    h.telephones source.telephones || source.company.telephones
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
