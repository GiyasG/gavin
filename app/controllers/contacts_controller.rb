class ContactsController < ApplicationController
  before_action :set_authority, only: [:create, :edit, :update, :destroy]

  # def index
  #   @contact = @authority.contacts.find(params[:id])
  # end
  #
  # def show
  # end
  #
  def new
  end

  def edit
    @contact = @authority.contacts.find(params[:id])
    #  @authority = Authority.find(params[:authority_id])
    #  @contact = contact.find(params[:id])
  end

  def create
    @contact = @authority.contacts.new(contact_params)
    if @contact.save
      redirect_to @authority, notice: "Contact successfully added!"
    else
      redirect_to @authority, alert: "Unable to add contact!"
    end
  end


  def update
    @contact = @authority.contacts.find(params[:id])

    if @contact.update(contact_params) # @contact.update
      redirect_to @authority, notice: "Contact successfully updated!"
    else
      redirect_to @authority, alert: "Unable to update contact!"
    end
  end


  def destroy
    @contact = @authority.contacts.find(params[:id])
    @contact.destroy
    redirect_to @authority, notice: "Contact deleted!"
  end

  private
    def set_authority
      @authority = Authority.find(params[:authority_id])
    end

    def contact_params
      params.require(:contact).permit(:street, :country, :city, :postcode, :phone, :email, :team_ids => [])
    end


end
