class AuthoritiesController < ApplicationController
  before_action :ensure_login, :set_authority, only: [:show, :new, :edit, :update, :destroy]
  before_filter :edit_authority_params, :only => [:update]
  # protect_from_forgery except: :index

  # GET /authorities
  # GET /authorities.json
  def index
    @client_ip = remote_ip()
    @client_country = Geokit::Geocoders::IpGeocoder.geocode(@client_ip).country
    @authority = Authority.first
    if @authority.nil?
      @authority = Authority.new
      @photo = Photo.new
      render '/authorities/new'
    end
    # binding.pry
    # @projects = @authority.projects #.order(:title).page(params[:page] || 1).per(4)
    # @papers = @authority.papers #.order(:title).page(params[:page] || 1).per(4)
    @contacts = @authority.contacts
    # @client_address = Geokit::Geocoders::GoogleGeocoder.geocode @contacts[0].postcode    # binding.pry
    @photos = Photo.no_ids.all
    @currents = @authority.projects.where("current = ?", true)

    @projs = Project.all.to_a
    records_number  = @projs.count
    records_per_page = 4
    whole_pages =  records_number / records_per_page
    last_page = records_number  % records_per_page
    pages = whole_pages + last_page
    @aprojects = []
    @c_page = 0
    if last_page > 0
    	(1..pages-1).each do
    		@aprojects << @projs.shift(records_per_page)
    	end
    		@aprojects << @projs.shift(last_page)
    else
    	(1..pages).each do
    		@aprojects << @projs.shift(records_per_page)
    	end
    end

    # binding.pry
    @paprs = Paper.all.to_a
    records_number  = @paprs.count
    records_per_page = 4
    whole_pages =  records_number / records_per_page
    last_page = records_number  % records_per_page
    pages = whole_pages + last_page
    @apapers = []
    @c_page = 0
    if last_page > 0
    	(1..pages-1).each do
    		@apapers << @paprs.shift(records_per_page)
    	end
    		@apapers << @paprs.shift(last_page)
    else
    	(1..pages).each do
    		@apapers << @paprs.shift(records_per_page)
    	end
    end


  end

  # GET /authorities/1
  # GET /authorities/1.json

  def aproject
    @authority = Authority.first
    @projs = Project.all.to_a
    records_number  = @projs.count
    records_per_page = 4
    whole_pages =  records_number / records_per_page
    last_page = records_number  % records_per_page
    pages = whole_pages + last_page
    @aprojects = []
    @c_page = params[:page]
    if last_page > 0
    	(1..pages-1).each do
    		@aprojects << @projs.shift(records_per_page)
    	end
    		@aprojects << @projs.shift(last_page)
    else
    	(1..pages).each do
    		@aprojects << @projs.shift(records_per_page)
    	end
    end
    # binding.pry
  end

def apaper
  @authority = Authority.first
  @paprs = Paper.all.to_a
  records_number  = @paprs.count
  records_per_page = 4
  whole_pages =  records_number / records_per_page
  last_page = records_number  % records_per_page
  pages = whole_pages + last_page
  @apapers = []
  @c_page = params[:page]
  if last_page > 0
    (1..pages-1).each do
      @apapers << @paprs.shift(records_per_page)
    end
      @apapers << @paprs.shift(last_page)
  else
    (1..pages).each do
      @apapers << @paprs.shift(records_per_page)
    end
  end
end

  def show
  end

  # GET /authorities/new
  def new
    @authority = Authority.new
    @photo = @authority.photos.new
  end

  # GET /authorities/1/edit
  def edit
  end

  # POST /authorities
  # POST /authorities.json
  def create
    # binding.pry
    @authority = Authority.new(authority_params)
    respond_to do |format|
      if @authority.save
        format.html { redirect_to @authority, notice: 'Authority was successfully created.' }
        format.json { render :show, status: :created, location: @authority }
      else
        format.html { render :new }
        format.json { render json: @authority.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authorities/1
  # PATCH/PUT /authorities/1.json
  def update

    respond_to do |format|

      if @authority.update(authority_params)
        format.html { redirect_to @authority, notice: 'Authority was successfully updated.' }
        format.json { render :show, status: :ok, location: @authority }
      else
        format.html { render :edit }
        format.json { render json: @authority.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authorities/1
  # DELETE /authorities/1.json
  def destroy
    @authority.destroy
    respond_to do |format|
      format.html { redirect_to authorities_url, notice: 'Authority was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_authority_params
    if authority_params[:photos_attributes][:"0"][:file].present?
      @photo = @authority.photos.find(authority_params[:photos_attributes][:"0"][:id])
      @photo.filename = authority_params[:photos_attributes][:"0"][:file].original_filename
      @photo.content_type = authority_params[:photos_attributes][:"0"][:file].content_type
      @photo.file_contents = authority_params[:photos_attributes][:"0"][:file].read
      @photo.save
      params[:authority][:photos_attributes][:"0"].except!(:file)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authority
      @authority = Authority.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authority_params
      params.require(:authority).permit(:title, :name, :surname, :position, :about, :dob, :sex,
                     photos_attributes: [:file, :description, :id])
    end
end
