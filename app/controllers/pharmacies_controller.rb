class PharmaciesController < ApplicationController
  include Authentication

  skip_before_action :verify_authenticity_token #, only: [:update]
  protect_from_forgery with: :null_session
  #protect_from_forgery except: [:update]

  helper_method :pharmacy
  before_action :authenticate, only: [:edit, :update]

  def show
    render locals: { drugs_search_results: query.result, drugs_search_form: drugs_search_form }
  end

  def index
    @pharmacies = Pharmacy.ordered.page params[:page]
  end

  def edit
    render locals: { pharmacy: pharmacy }
  end

  def update
    filename = uploaded_io.original_filename
    if ImportFileService::EXTENTIONS.include? File.extname(filename)
      pharmacy.price_lists.create! file: uploaded_io
      flash[:notice] = "Файл удачно загружен, в очередь на импорт в базу"
      redirect_to edit_pharmacy_url pharmacy
    else
      pharmacy.errors.add :file, 
        "Загрузите файл в формате #{ImportFileService::EXTENTIONS.join(',')}"
      render :edit
    end

  rescue ImportService::Error => err
    flash[:error] = err.message
    render :edit
  end

  private

  def uploaded_io
    params[:file] || params[:pharmacy]['file'] rescue nil
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
