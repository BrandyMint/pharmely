class DrugsController < ApplicationController
  def index
    if drugs_search_form.q.present?
      result = DrugsIndex.
        query( prefix: { name: drugs_search_form.query } ).
        highlight(fields: { name: {"term_vector" => "with_positions_offsets"} }).
        page(params[:page])
    else
      result = DrugsIndex::Drug.filter{ match_all }.page(params[:page])
    end
    render locals: { drugs_search_results: result, drugs_search_form: drugs_search_form }
  end

end
