class DrugsQuery
  include Virtus.model

  attribute :form,     DrugsSearchForm
  attribute :page,     Integer
  attribute :pharmacy, Pharmacy
  attribute :show_for_order

  def result
    if form.q.present?
      by_name
    else
      all
    end

    by_pharmacy if pharmacy.present?
    sorting if form.sortable_column.present?
    filter_for_order unless show_for_order

    scope.page page
  end

  private

  def filter_for_order
    @scope = scope.filter{ price > 0 }
  end

  def by_pharmacy
    @scope = scope.filter( term: { pharmacy_id: pharmacy.id } )
  end

  def sorting
    @scope = scope.order form.sortable_column => form.order_key
  end

  def scope
    @scope ||= DrugsIndex::Drug
  end

  def all
    @scope = scope.filter{ match_all }
  end

  def by_name
    @scope = scope.
      #query( match: { name: form.query } ).
      query( bool: { should: [{ match: { name: form.query } }, { prefix: { name: form.query }}]} ).
      highlight(fields: { name: {"term_vector" => "with_positions_offsets"} })
  end

end
