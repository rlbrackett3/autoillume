class DraftPostsController < ApplicationController
  # GET /draft_posts
  # GET /draft_posts.json
  def index
    @draft_posts = Post.drafts.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @draft_posts }
    end
  end

  # GET /draft_posts/1
  # GET /draft_posts/1.json
  def show
    @draft_post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @draft_post }
    end
  end

end
