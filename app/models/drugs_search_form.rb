class DrugsSearchForm
  include ActiveModel::Model

  attr_accessor :q
  attr_accessor :sortable_column
  attr_accessor :order
  attr_accessor :city
  attr_accessor :open_only

  def query
    value = q
    return value if value.blank?
    return q.mb_chars.downcase.to_s
  end

  def available_cities
    query = Company.select(:city).union(
      Pharmacy.select(:city)).to_sql

    ActiveRecord::Base.connection.execute(query).to_a
      .map(&:values).flatten.compact.sort
  end

  def to_s
    q.to_s
  end

  def order_key
    order.to_s == 'desc' ? :desc : :asc
  end

  def to_hash
    { q: q, city: city, open_only: open_only,
      sortable_column: sortable_column, order: order }
  end

  def open_only?
    open_only == '1' ? true : false
  end
end
