class CompanyDecorator < Draper::Decorator
  delegate_all

  def logo size='64x64'
    if source.logo.present?
      h.image_tag source.logo.url, size: size
    end
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
