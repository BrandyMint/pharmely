class PharmaciesController < ApplicationController
  helper_method :pharmacy

  def show
    render locals: { drugs_search_results: query.result, drugs_search_form: drugs_search_form }
  end

  def index
    @pharmacies = Pharmacy.ordered.page params[:page]
  end

  private

  def pharmacy
    @pharmacy ||= Pharmacy.find params[:id]
  end

  def query
    DrugsQuery.new form: drugs_search_form, page: params[:page], pharmacy: pharmacy
  end

end
