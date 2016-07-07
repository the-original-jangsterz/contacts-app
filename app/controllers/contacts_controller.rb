class ContactsController < ApplicationController
  def show_contact
    @contact = Contact.first
    render 'single_contact.html.erb'
  end
end
