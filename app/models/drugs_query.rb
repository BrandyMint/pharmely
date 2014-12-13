class DrugsQuery
  include Virtus.model

  attribute :form,     DrugsSearchForm
  attribute :page,     Integer
  attribute :pharmacy, Pharmacy

  def result
    if form.q.present?
      by_name
    else
      all
    end

    by_pharmacy if pharmacy.present?

    scope.page page
  end

  private

  def by_pharmacy
    @scope = scope.filter{ pharmacy_id == pharmacy.id }
  end

  def scope
    @scope ||= DrugsIndex::Drug
  end

  def all
    @scope = scope.filter{ match_all }
  end

  def by_name
    @scope = scope.
      query( prefix: { name: form.query } ).
      highlight(fields: { name: {"term_vector" => "with_positions_offsets"} })
  end

end
