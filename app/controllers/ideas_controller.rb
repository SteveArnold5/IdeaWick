class IdeasController < ApplicationController
  before_filter :require_user, :except => [:vote,:viewIdeas]
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = current_user.ideas.page(params["page"])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @site = Site.find(params[:site_id])
    @idea = Idea.new(params[:idea])
    @idea.user = current_user
    @site.ideas. << @idea
    @ideas = @site.ideas.page(params["page"])

    respond_to do |format|
      if @idea.save
        if params[:post_to_facebook] == 'yes'
          facebook_user.feed!(:message => "Posted an idea to #{base_url}: \"#{@idea.ideaText}\"", :link => "#{@base_url}", :caption => "View Site")
        end
        format.html { redirect_to :controller=>'ideas', :action => 'viewIdeas' }
        format.json { render json: @idea, status: :created, location: @idea }
        format.js
      else
        format.html { render :template => '/ideas/viewIdeas' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :ok }
    end
  end
  
  def vote
    @idea = Idea.find(params[:id])
    @vote = Vote.new()
    @vote.user = current_user
    @vote.idea = @idea
    
    respond_to do |format|
      if @vote.save
        format.html { redirect_to :controller=>'ideas', :action => 'viewIdeas'}
        format.json { render json: @idea, status: :created, location: @idea }
        format.js   { render :json => { :id => @idea.id, :voteCount => @idea.votes.count }.to_json, content_type: 'text/json' } 
      else
        format.html { render :template => 'ideas/viewIdeas' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def viewIdeas
    @site = Site.find_by_subdomain(request.subdomain)
    @idea = Idea.new
    @idea.site = @site
    
    @ideas = Idea.where("site_id = ?", @site.id).order("votes_count desc").page(params["page"])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end
  
end
