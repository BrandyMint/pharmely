module DrugsHelper
  def stock_quantity drug
    if drug.stock_quantity>3
      'много'
    else
      'мало'
    end
  end
end
