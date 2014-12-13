class DrugsController < ApplicationController
  def index
    render locals: { drugs_search_results: query.result, drugs_search_form: drugs_search_form }
  end

  private

  def query
    DrugsQuery.new form: drugs_search_form, page: params[:page]
  end

end
