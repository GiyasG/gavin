class TeamContactsController < ApplicationController
  before_action :ensure_login, :set_team_contacts, only: [:edit, :new, :update, :destroy]

  def new
    @team=Team.find(params[:id])
    @contact = Contact.new
  end

  def edit
    @team=Team.find(params[:id])
    @contact = Contact.find(params[:contact_id])
  end

  def create
    @contact = Contact.new(contact_teams_params)

    respond_to do |format|
      if @contact.save
        @team = Team.find(params[:id])
        # contact = Contact.find(params[@contact.id])
        @team.contacts << @contact
        format.html { redirect_to view_teams_path, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @contact.update(contact_teams_params)
        @team = Team.find(params[:id])
        contact = Contact.find(params[:contact_id])
        @team.contacts.destroy contact
        @team.contacts << contact
        format.html { redirect_to view_teams_path, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end


  def contactdelete
    @team = Team.find(params[:id])
    # byebug
    @contact = Contact.find(params[:contact_id])
    contact = Contact.find(params[:contact_id])

    if @contact.destroy
    @team.contacts.destroy contact
      respond_to do |format|
        format.html { redirect_to view_teams_path, notice: 'Contact was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_contacts
      @team = Team.find(params[:id])
    end

    def set_contact_teams
      @contact = Contact.find(params[:contact_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def team_contacts_params
      params.require(:team).permit(:team_title, :team_name, :team_surname, :team_position, :team_about, :team_dob, :team_sex, :photo, :project_ids => [], :papers_ids => [], :contacts_ids => [])
    end

    def contact_teams_params
      params.require(:contact).permit(:street, :country, :city, :postcode, :phone, :email, :team_ids => [])
    end

end
