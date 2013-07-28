class HomeController < ApplicationController
  def index
    @site = Site.find_by_subdomain(request.subdomain)
    if @site != nil
      redirect_to "/viewIdeas"
    else
      respond_to do |format|
        format.html # index.html.erb
      end
    end
  end
end
