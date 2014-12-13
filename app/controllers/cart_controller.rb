class CartController < ApplicationController
  def show
  end

  def destroy
    cart.destroy!

    flash[:notice] = "Корзина очищена"
    redirect_to root_url
  end
end
