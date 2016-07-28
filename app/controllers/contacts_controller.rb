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
    @contact = Contact.new
    render 'new.html.erb'
  end

  def create
    latlong = Geocoder.coordinates(params[:address])
    if latlong
      computed_latitude = latlong[0]
      computed_longitude = latlong[1]
    else
      computed_latitude = nil
      computed_longitude = nil
    end
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      address: params[:address],
      latitude: computed_latitude,
      longitude: computed_longitude,
      bio: params[:bio],
      user_id: current_user.id
    )
    if @contact.save
      redirect_to "/contacts/#{@contact.id}"
    else
      render 'new.html.erb'
    end
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
    if latlong
      computed_latitude = latlong[0]
      computed_longitude = latlong[1]
    else
      computed_latitude = nil
      computed_longitude = nil
    end
    @contact = Contact.find_by(id: params[:id])
    if @contact.update(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      address: params[:address],
      latitude: computed_latitude,
      longitude: computed_longitude,
      bio: params[:bio]
    )
      redirect_to "/contacts/#{@contact.id}"
    else
      render 'edit.html.erb'
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    redirect_to "/contacts"
  end
end
