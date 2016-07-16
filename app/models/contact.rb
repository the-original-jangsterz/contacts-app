class Contact < ActiveRecord::Base
  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_all_johns
    Contact.where(first_name: "John")
  end
end
