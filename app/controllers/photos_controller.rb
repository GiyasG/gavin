class PhotosController < ApplicationController
  require "mini_magick"
  before_action :set_authority, only: [:edit, :update, :destroy]
  skip_before_action :ensure_login, only: [:show, :show_authority, :show_paper, :show_project, :show_team]

    # GET /photos
    # GET /photos.json
    def index
      @photos = Photo.all
    end

    # GET /photos/1
    # GET /photos/1.json
    def show
      @photo = Photo.find(params[:id])
      send_data(@photo.file_contents,
                type: @photo.content_type,
                filename: @photo.filename)
    end


    def show_authority
      @photo = Photo.find_by(:authority_id=>params[:authority_id])
      send_data(@photo.file_contents,
                type: @photo.content_type,
                filename: @photo.filename)
    end

    def show_project
      @photo = Photo.find_by(:project_id=>params[:project_id])
      send_data(@photo.file_contents,
                type: @photo.content_type,
                filename: @photo.filename)
    end

    def show_team
      @team=Team.find(params[:team_id])
      @photos = @team.photos
      @photos.each do |photo|
      # binding.pry
      send_data(photo.file_contents,
                type: photo.content_type,
                filename: photo.filename)
              end
    end

    def show_paper
      @photo = Photo.find_by(:paper_id=>params[:paper_id])
      send_data(@photo.file_contents,
                type: @photo.content_type,
                filename: @photo.filename)
    end

    # GET /photos/new
    def new
      @photo = Photo.new
    end

    # POST /photos
    # POST /photos.json
    def create
      @photo = @authority.photos.new(photo_params)
      # binding.pry
      respond_to do |format|
        if @photo.save
          format.html { redirect_to photos_path, notice: 'Photo was successfully created.' }
          format.json { render action: 'show', status: :created, location: @photo }
        else
          format.html { render action: 'new' }
          format.json { render json: @photo.errors, status: :unprocessable_entity }
        end
      end
    end

    def create_photo
      @photo = Photo.new(photo_params)
      if @photo.save
        redirect_to @authority, notice: "Photo successfully added!"
      else
        redirect_to @authority, alert: "Unable to add Photo!"
      end
    end

    def create_photo_standalone
      @photo = Photo.new(photo_params)
      if @photo.save
        redirect_to photos_index_path, notice: "Photo successfully added!"
      else
        redirect_to photos_index_path, alert: "Unable to add Photo!"
      end
    end

    # PATCH/PUT /photos/1
    # PATCH/PUT /photos/1.json
    def update
      respond_to do |format|
        binding.pry
        if @photo.update(photo_params)
          format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @photo.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /photos/1
    # DELETE /photos/1.json
    def destroy
      @photo.destroy
      respond_to do |format|
        format.html { redirect_to photos_url }
        format.json { head :no_content }
      end
    end

    def destroy_standalone
      @photo=Photo.find(params[:id])
      @photo.destroy
      respond_to do |format|
        format.html { redirect_to photos_index_path }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_authority
        @authority = Authority.find(params[:authority_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def photo_params
        params.require(:photo).permit(:file, :description, :team_ids => [],)
      end

end
