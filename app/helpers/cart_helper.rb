module CartHelper
  def add_to_cart_link drug
    link_to 'В корзину', cart_items_url(drug_id: drug.id), method: :post, class: 'btn btn-default hoverable'
  end
end
