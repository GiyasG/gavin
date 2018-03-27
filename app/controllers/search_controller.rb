class SearchController < ApplicationController

  skip_before_action :ensure_login

  def index
    @projects = Project.all
    @papers = Paper.all
     if params[:search] != ""
       @results = Project.search(params[:search]).order("created_at DESC") + Paper.search(params[:search]).order("created_at DESC")
     else
       @results = nil
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_search
      @project = Project.all
    end

    def set_paper_search
      @paper = Paper.all
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def project_search_params
      params.require(:project).permit(:title, :about, :started, :finished, :url, :team_ids => [])
    end

    def paper_search_params
      params.require(:paper).permit(:title, :description, :url, :published, :team_ids => [])
    end

end
