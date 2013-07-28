class CommentsController < ApplicationController
  before_filter :require_user
  # POST /comments
  # POST /comments.json
  def create
    @idea = Idea.find(params[:idea_id])
    @comment = current_user.comments.create(params[:comment])
    @comment.idea = @idea
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :controller=>'ideas', :action => 'viewIdeas' }
        format.json { render json: @comment, status: :created, location: @idea }
        format.js
      else
        format.html { render :template => 'ideas/viewIdeas' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.json { head :ok }
      format.js
    end
  end
  
end
