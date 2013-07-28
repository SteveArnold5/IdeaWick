class SitesController < ApplicationController
  before_filter :require_user, :except => ["browse"]
  # GET /sites
  # GET /sites.json
  def index
    @sites = current_user.sites.page(params["page"])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
     @site = current_user.sites.find(params[:id])
   end

  # POST /sites
  # POST /sites.json
  def create
    @site = current_user.sites.create(params[:site])
    respond_to do |format|
      if @site.save
        format.html { flash_and_redirect("successfully saved!", sites_url) }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = current_user.sites.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { flash_and_redirect("successfully updated!", sites_url) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = current_user.sites.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { flash_and_redirect("successfully deleted", sites_url) }
      format.json { head :ok }
    end
  end
  
  def browse
    @sites = Site.order("subdomain").page(params["page"])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end 
end
