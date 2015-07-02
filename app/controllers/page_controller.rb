class PageController < ApplicationController
  def show
     @page = Page.where(path: params[:path]).first
  end
end
