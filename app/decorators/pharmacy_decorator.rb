class PharmacyDecorator < Draper::Decorator
  delegate_all

  delegate :logo, to: :decorated_company

  def work_time
    work_time_for(:week_day_works, source.work_time)
  end

  def work_weekend_time
    work_time_for(:weekend_works)
  end

  def works_now?
    source.open? ? 'открыта' : 'закрыта'
  end

  def updated_at
    I18n.l source.updated_at, format: :short
  end

  def drugs_link
    h.link_to "#{drugs.count} позиций", h.pharmacy_url(source)
  end

  def decorated_company
    CompanyDecorator.decorate source.company
  end

  def telephones
    h.telephones source.telephones || source.company.telephones
  end

  def full_address
    "#{source.city}, #{source.address}"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  private

  def work_time_for(type, default_value = 'не установлено')
    return 'круглосуточно' if source.around_the_clock?

    from = "#{type}_from".to_sym
    till = "#{type}_till".to_sym

    if source.send(from).present?
      [
        I18n.l(source.send(from), format: :hm),
        I18n.l(source.send(till), format: :hm)
      ].join('-')
    else
      default_value
    end
  end
end
