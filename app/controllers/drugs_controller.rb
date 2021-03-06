class DrugsController < ApplicationController
  def welcome
    if drugs_search_form.q.present?
      index
    end
  end

  def index
    render :index, locals: { drugs_search_results: query.result, drugs_search_form: drugs_search_form }
  end

  private

  def query
    DrugsQuery.new form: drugs_search_form, page: params[:page],
      with_price_only: Settings.show_drugs_with_price_only,
      quantity_gt_0: true
  end

end
