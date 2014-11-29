class SearchForm
  include ActiveModel::Model

  attr_accessor :q

  #validates :q, presence: true

  def query
    value = q
    return value if value.blank?
    return q.mb_chars.downcase.to_s
  end
end
