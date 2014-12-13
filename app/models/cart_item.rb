class CartItem
  include Virtus.model

  attribute :drug, Drug
  attribute :count, Integer, default: 1
end
