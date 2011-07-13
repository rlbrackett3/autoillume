class PreviewPostsController < ApplicationController

  # GET /preview_posts/1
  # GET /preview_posts/1.json
  def show
    @preview_post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @preview_post }
    end
  end

  # GET /preview_posts/new
  # GET /preview_posts/new.json
  # def new
  #   @preview_post = PreviewPost.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @preview_post }
  #   end
  # end

  # POST /preview_posts
  # POST /preview_posts.json
  # def create
  #   @preview_post = PreviewPost.new(params[:preview_post])

  #   respond_to do |format|
  #     if @preview_post.save
  #       format.html { redirect_to @preview_post, notice: 'Preview post was successfully created.' }
  #       format.json { render json: @preview_post, status: :created, location: @preview_post }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @preview_post.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /preview_posts/1/edit
  def edit
    @preview_post = Post.find(params[:id])
  end

  # PUT /preview_posts/1
  # PUT /preview_posts/1.json
  def update
    @preview_post = Post.find(params[:id])

    respond_to do |format|
      if @preview_post.update_attributes(params[:preview_post])
        format.html { redirect_to post_path(@post), notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @preview_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preview_posts/1
  # DELETE /preview_posts/1.json
  def destroy
    @preview_post = Post.find(params[:id])
    @preview_post.destroy

    respond_to do |format|
      format.html { redirect_to preview_posts_url }
      format.json { head :ok }
    end
  end
end
