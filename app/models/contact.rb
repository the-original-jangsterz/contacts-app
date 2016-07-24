class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_all_johns
    Contact.where(first_name: "John")
  end
end
