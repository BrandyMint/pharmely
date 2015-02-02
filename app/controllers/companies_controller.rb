class CompaniesController < ApplicationController
  def index
    @companies = Company.ordered.page params[:page]
  end
  def show
    @company = company
  end

  private

  def company
    Company.find params[:id]
  end

end
