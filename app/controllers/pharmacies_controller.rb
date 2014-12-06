class PharmaciesController < ApplicationController
  def show
    @pharmacy = Pharmacy.find params[:id]
    pharmacy = @pharmacy
    @drugs_search_results = DrugsIndex::Drug.filter{ pharmacy_id == pharmacy.id }.page(params[:page])
  end

  def index
    @pharmacies = Pharmacy.ordered.page params[:page]
  end
end
