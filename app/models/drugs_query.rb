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
    filter_closed_pharmacies if form.open_only?

    scope.page page
  end

  private

  def filter_without_price
    @scope = scope.filter{ price > 0 }
  end

  def filter_closed_pharmacies
    now = Time.now.strftime("%H%M").to_i

    @scope = if weekend_now?
      scope
        .filter { pharmacy.weekend_works_from <= now }
        .filter { pharmacy.weekend_works_till >= now }
    else
      scope
        .filter { pharmacy.week_day_works_from <= now }
        .filter { pharmacy.week_day_works_till >= now }
    end
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

  private

  def weekend_now?
    now = Time.now
    now.saturday? || now.sunday?
  end
end
