class ContactsController < ApplicationController
  def show_contact
    @contact = Contact.first
    render 'single_contact.html.erb'
  end

  def show_contacts
    @contacts = Contact.all
    render 'all_contacts.html.erb'
  end
end
