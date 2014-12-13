class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :drugs_search_form, :cart

  private

  def drugs_search_form
    @drugs_search_form ||= DrugsSearchForm.new params[:drugs_search_form]
  end

  def cart
    session[:cart] ||= Cart.new
  end
end
