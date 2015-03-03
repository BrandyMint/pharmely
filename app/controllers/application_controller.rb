class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :drugs_search_form, :cart

  private

  def authenticate_admin_user!
    return true if Rails.env.development?
    authenticate_or_request_with_http_basic("admin access") do |name, password|
      Secrets.admin.present? && name == Secrets.admin.name && password == Secrets.admin.password
    end
  end

  def drugs_search_form
    @drugs_search_form ||= DrugsSearchForm.new params[:drugs_search_form]
  end

  def cart
    session[:cart] ||= Cart.new
  end
end
