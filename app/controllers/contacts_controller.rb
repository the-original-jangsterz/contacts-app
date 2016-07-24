class ContactsController < ApplicationController
  def index
    # STRAIGHT UP RUBY
    # all_contacts = Contact.all
    # @contacts = []
    # all_contacts.each do |contact|
    #   if contact.user_id == current_user.id
    #     @contacts << contact
    #   end
    # end

    # STRAIGHT UP ACTIVE RECORD
    # @contacts = Contact.where(user_id: current_user.id)

    # STRAIGHT UP RAILS ASSOCIATIONS
    if current_user
      if params[:group_id]
        selected_group = Group.find_by(id: params[:group_id])
        @contacts = selected_group.contacts.where(user_id: current_user.id)
      else
        @contacts = current_user.contacts
      end
      render 'index.html.erb'
    else
      flash[:warning] = "You must be logged in to see this page!"
      redirect_to '/login'
    end
  end

  def new
    render 'new.html.erb'
  end

  def create
    latlong = Geocoder.coordinates(params[:address])
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      address: params[:address],
      latitude: latlong[0],
      longitude: latlong[1],
      bio: params[:bio],
      user_id: current_user.id
    )
    @contact.save
    redirect_to "/contacts/#{@contact.id}"
  end

  def show 
    @contact = Contact.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
    render 'edit.html.erb'
  end

  def update
    latlong = Geocoder.coordinates(params[:address])
    @contact = Contact.find_by(id: params[:id])
    @contact.update(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      address: params[:address],
      latitude: latlong[0],
      longitude: latlong[1],
      bio: params[:bio]
    )
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    redirect_to "/contacts"
  end
end
