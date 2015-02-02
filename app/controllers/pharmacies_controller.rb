class PharmaciesController < ApplicationController
  include Authentication

  helper_method :pharmacy
  before_action :authenticate, only: [:edit]

  def show
    render locals: { drugs_search_results: query.result, drugs_search_form: drugs_search_form }
  end

  def index
    @pharmacies = Pharmacy.ordered.page params[:page]
  end

  def update
    filename = uploaded_io.original_filename
    if File.extname(filename)=='.xlsx'
      drugs = ImportService.new(pharmacy: pharmacy, file: uploaded_io).perform
      flash[:notice] = "Удачно загружено #{drugs.count} товаров"
    else
      pharmacy.errors.add :file, 'Загрузите файл в формате .xlsx'
    end

    render :edit
  rescue ImportService::Error => err
  end

  private

  def uploaded_io
    params[:pharmacy]['file']
  end

  def company
    pharmacy.company
  end

  def pharmacy
    @pharmacy ||= Pharmacy.find params[:id]
  end

  def query
    DrugsQuery.new form: drugs_search_form, page: params[:page], pharmacy: pharmacy
  end

end
