class AboutController < ApplicationController
  def index
    @page = Page.where(path: "about").first
  end
end
