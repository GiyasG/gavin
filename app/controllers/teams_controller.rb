class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  skip_before_action :ensure_login, only: [:index]
  before_filter :edit_params, :only => [:update]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team=Team.find(params[:id])
  end

  def view
  @team = Team.all
  if @team.nil?
    @team = Team.new
    @photo = Photo.new
    render '/teams/new'
  end
  end


  # GET /teams/new
  def new
    @team = Team.new
    @photo = @team.photos.new
  end

  # GET /teams/1/edit
  def edit
    @team=Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to view_teams_path, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_params
    if team_params[:photos_attributes][:"0"][:file].present?
      @team = Team.find(params[:id])
      @photo = @team.photos.find(team_params[:photos_attributes][:"0"][:id])
      @photo.filename = team_params[:photos_attributes][:"0"][:file].original_filename
      @photo.content_type = team_params[:photos_attributes][:"0"][:file].content_type
      @photo.file_contents = team_params[:photos_attributes][:"0"][:file].read
      @photo.save
      params[:team][:photos_attributes][:"0"].except!(:file)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:title, :name, :surname, :position, :about, :dob, :sex, :project_ids => [], :papers_ids => [], :contacts_ids => [],
                     photos_attributes: [:file, :description, :id])
    end
end
