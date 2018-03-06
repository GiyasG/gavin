class ProjectsController < ApplicationController
  before_action :set_authority, only: [:show, :create, :edit, :update, :destroy]
  before_filter :edit_params, :only => [:update]

  # def index
  # end

  # def view
  # end

   def show
     @project = @authority.projects.find(params[:id])
     @team = Team.all
   end
  #
  def new
    @project = @authority.projects.new
    @photo = @project.photos.new
  end

  def edit
    @project = @authority.projects.find(params[:id])
    # @team = Team.all
  end

  def create
    @project = @authority.projects.new(project_params)
    if @project.save
      redirect_to @authority, notice: "Project successfully added!"
    else
      @project.errors.full_messages.each do |message|
        @notice_p = message
      end
      redirect_to @authority, alert: "Unable to add project - "+ @notice_p
    end
  end


  def update

    respond_to do |format|

      @project = @authority.projects.find(params[:id])

      # team_id = params[:project][:team_ids]
      # check_precense = @project.teams.find_by_id(params[:project][:team_ids])
      # if team_id and check_precense.nil?
      #   team = Team.find(team_id)
      #   @project.teams << team
      # end

      if @project.update_attributes(project_params) # @project.update
        redirect_to @authority, notice: "Project successfully updated!"
      else
        redirect_to @authority, alert: "Unable to update project!"
      end
    end

  end


  def destroy
    @project = @authority.projects.find(params[:id])
    @project.destroy
    redirect_to @authority, notice: "Project deleted!"
  end

  def add_delete_team
    @authority = Authority.find(params[:authority_id])
    @project = Project.find(params[:project_id])
    # team = Team.find(params[:id])
    # byebug
    # if request.get?
    #    @project.teams << team
    #    redirect_to @authority, notice: "Team memeber was successfully added"
    # elsif request.delete?
    #     @project.teams.destroy team
    #     # byebug
    #     redirect_to @authority, notice: "Team memeber was successfully deleted"
    # end
  end

  def edit_params
    if project_params[:photos_attributes][:"0"][:file].present?
      @photo = @project.photos.find(authority_params[:photos_attributes][:"0"][:id])
      @photo.filename = authority_params[:photos_attributes][:"0"][:file].original_filename
      @photo.content_type = authority_params[:photos_attributes][:"0"][:file].content_type
      @photo.file_contents = authority_params[:photos_attributes][:"0"][:file].read
      @photo.save
      params[:project][:photos_attributes][:"0"].except!(:file)
    end
  end


  private
    def set_authority
      @authority = Authority.find(params[:authority_id])
    end

    def project_params
      params.require(:project).permit(:title, :about, :started, :finished, :url,
                                       photos_attributes: [:file, :description, :id])
    end
end
