class PageController < ApplicationController
  def show
    @page = Page.find_by! :path => params[:path]
  end
end
