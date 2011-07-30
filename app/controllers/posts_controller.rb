class PostsController < ApplicationController
  before_filter  :admin_login_required, except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    # @search = Post.search(params[:search])
    # @posts = @search.relation.published.order('published_at DESC')
    @q = Post.search(params[:q])
    @posts = @q.result(:distinct => true).published.order('published_at DESC')
    # @posts = Post.published.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    find_admin
    @post = @admin.posts.new

    # build a text_section
    text_section = @post.text_sections.build unless @post.text_sections.any?
    # build a photo in a photo_section
    photo_section = @post.photo_sections.build unless @post.photo_sections.any?
    photo = photo_section.build_photo if photo_section

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @post }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    find_admin
    @post = @admin.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        if @post.state == "draft"
          format.html { redirect_to draft_post_path(@post), notice: 'Post was successfully created.' }
          format.json { render json: @post, status: :created, location: @post }
        elsif @post.state == "published"
          format.html { redirect_to post_path(@post), notice: 'Post was successfully created.' }
          format.json { render json: @post, status: :created, location: @post }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    # build a text_section
    text_section = @post.text_sections.build unless @post.text_sections.any?
    # build a photo in a photo_section
    photo_section = @post.photo_sections.build unless @post.photo_sections.any?
    photo = photo_section.build_photo if photo_section

  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to post_path(@post), notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  private

  def find_admin
    @admin = current_admin
  end
end
