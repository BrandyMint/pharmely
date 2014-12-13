class CartItemsController < ApplicationController
  def create
    cart.add_drug drug
    flash[:notice] = "Перепарат <b>#{drug.name}</b> добавлен в корзину".html_safe
    redirect_to request.referer
  end

  private

  def drug
    @drug ||= Drug.find params[:drug_id]
  end

end
