class DrugsSearchForm
  include ActiveModel::Model

  attr_accessor :q

  def query
    value = q
    return value if value.blank?
    return q.mb_chars.downcase.to_s
  end

  def to_s
    q
  end
end
