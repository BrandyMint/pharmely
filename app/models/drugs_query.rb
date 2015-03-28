class DrugsQuery
  include Virtus.model

  attribute :form,     DrugsSearchForm
  attribute :page,     Integer
  attribute :pharmacy, Pharmacy
  attribute :with_price_only, Boolean, default: false

  def result
    if form.q.present?
      by_name
    else
      all
    end

    by_city if form.city.present?
    by_pharmacy if pharmacy.present?
    sorting if form.sortable_column.present?
    filter_without_price if with_price_only

    scope.page page
  end

  private

  def filter_without_price
    @scope = scope.filter{ price > 0 }
  end

  def by_pharmacy
    @scope = scope.filter( term: { pharmacy_id: pharmacy.id } )
  end

  def by_city
    @scope = scope.query( match: { 'pharmacy.city' => form.city } )
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
