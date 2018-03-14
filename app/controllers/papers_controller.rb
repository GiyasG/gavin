class PapersController < ApplicationController
  before_action :set_authority, only: [:show, :create, :edit, :update, :destroy]
  skip_before_action :ensure_login, only: [:show]
  before_filter :edit_params, :only => [:update]

  # def index
  # end

  # def view
  # end

   def show
     @paper = @authority.papers.find(params[:id])
     @team = Team.all
   end
  #
  def new
    @paper = @authority.papers.new
    @photo = @paper.photos.new
  end

  def edit
    @paper = @authority.papers.find(params[:id])
    @team = Team.all
  end

  def create
    # binding.pry
    @paper = @authority.papers.new(paper_params)
    if @paper.save
      redirect_to @authority, notice: "Project successfully added!"
    else
      @paper.errors.full_messages.each do |message|
        @notice_p = message
      end
      redirect_to @authority, alert: "Unable to add paper - "+ @notice_p
    end
  end


  def update

      @paper = @authority.papers.find(params[:id])

      team_id = params[:paper][:team_ids]
      check_precense = @paper.teams.find_by_id(params[:paper][:team_ids])
      if team_id and check_precense.nil?
        team = Team.find(team_id)
        @paper.teams << team
      end

      if @paper.update_attributes(paper_params) # @paper.update
        redirect_to @authority, notice: "Paper successfully updated!"
      else
        redirect_to @authority, alert: "Unable to update paper!"
      end

  end


  def destroy
    @paper = @authority.papers.find(params[:id])
    @paper.destroy
    redirect_to @authority, notice: "Paper deleted!"
  end

  def add_delete_team
    @authority = Authority.find(params[:authority_id])
    @paper = Project.find(params[:paper_id])
    team = Team.find(params[:id])
    if request.get?
       @paper.teams << team
       redirect_to @authority, notice: "Team memeber was successfully added"
    elsif request.delete?
        @paper.teams.destroy team
        redirect_to @authority, notice: "Team memeber was successfully deleted"
    end
  end

    def edit_params
    if paper_params[:photos_attributes][:"0"][:file].present?
      @paper = Paper.find(params[:id])
      @photo = @paper.photos.find(paper_params[:photos_attributes][:"0"][:id])
      @photo.filename = paper_params[:photos_attributes][:"0"][:file].original_filename
      @photo.content_type = paper_params[:photos_attributes][:"0"][:file].content_type
      @photo.file_contents = paper_params[:photos_attributes][:"0"][:file].read
      @photo.save
      params[:paper][:photos_attributes][:"0"].except!(:file)
    end
  end


  private
    def set_authority
      @authority = Authority.find(params[:authority_id])
    end

    def paper_params
      params.require(:paper).permit(:title, :description, :published, :url, :team_ids => [],
                                       photos_attributes: [:file, :description, :id])
    end

end
