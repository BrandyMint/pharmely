class DrugsSearchForm
  include ActiveModel::Model

  attr_accessor :q
  attr_accessor :sortable_column
  attr_accessor :order

  def query
    value = q
    return value if value.blank?
    return q.mb_chars.downcase.to_s
  end

  def to_s
    q.to_s
  end

  def order_key
    order.to_s == 'desc' ? :desc : :asc
  end

  def to_hash
    { q: q, sortable_column: sortable_column, order: order }
  end
end
