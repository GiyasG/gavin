class AuthoritiesController < ApplicationController
  before_action :set_authority, only: [:show, :edit, :update, :destroy]

  # GET /authorities
  # GET /authorities.json
  def index
    # binding.pry
    @authorities = Authority.all
  end

  # GET /authorities/1
  # GET /authorities/1.json
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

      # if authority_params[:photos_attributes][:filename].nil?
      #     @authority.photos.find_by(:authority_id => params[:id]) do |t|
      #     authority_params[:photos_attributes][:filename].original_filename = t.filename
      #     authority_params[:photos_attributes][:filename].content_type = t.content_type
      #     authority_params[:photos_attributes][:filename].file_contents = t.file_contents
      #     binding.pry
      #   end
      # end


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
