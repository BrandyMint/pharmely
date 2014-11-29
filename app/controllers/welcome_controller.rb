class WelcomeController < ApplicationController
  def index
    if search_form.q.present?
      result = PharmacyIndex.
        query( prefix: { name: search_form.query } ).
        highlight(fields: { name: {"term_vector" => "with_positions_offsets"} }).
        page(params[:page])
      render locals: { search_results: result, search_form: search_form }
    else
      render locals: { search_results: nil, search_form: search_form }
    end
  end

  def all
    result = PharmacyIndex.filter{ match_all }.page(params[:page])
    render :index, locals: { search_results: result, search_form: search_form }
  end

  private

  def search_form
    @search_form ||= SearchForm.new params[:search_form]
  end
end
