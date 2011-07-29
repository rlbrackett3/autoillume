class ExternalLinksController < ApplicationController
  before_filter  :admin_login_required, except: [:show]
  # GET /external_links
  # GET /external_links.json
  def index
    @external_links = ExternalLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @external_links }
    end
  end

  # GET /external_links/1
  # GET /external_links/1.json
  def show
    @external_link = ExternalLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @external_link }
    end
  end

  # GET /external_links/new
  # GET /external_links/new.json
  def new
    @external_link = ExternalLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @external_link }
    end
  end

  # GET /external_links/1/edit
  def edit
    @external_link = ExternalLink.find(params[:id])
  end

  # POST /external_links
  # POST /external_links.json
  def create
    @external_link = ExternalLink.new(params[:external_link])

    respond_to do |format|
      if @external_link.save
        format.html { redirect_to @external_link, notice: 'External link was successfully created.' }
        format.json { render json: @external_link, status: :created, location: @external_link }
      else
        format.html { render action: "new" }
        format.json { render json: @external_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /external_links/1
  # PUT /external_links/1.json
  def update
    @external_link = ExternalLink.find(params[:id])

    respond_to do |format|
      if @external_link.update_attributes(params[:external_link])
        format.html { redirect_to @external_link, notice: 'External link was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @external_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_links/1
  # DELETE /external_links/1.json
  def destroy
    @external_link = ExternalLink.find(params[:id])
    @external_link.destroy

    respond_to do |format|
      format.html { redirect_to external_links_url }
      format.json { head :ok }
    end
  end

  def sort
    params[:external_link].each_with_index do |id, index|
      ExternalLink.update_all(['link_order=?', index + 1], ['id=?', id])
    end
    render :nothing => true
  end
end
