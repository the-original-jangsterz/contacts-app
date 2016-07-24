class Group < ActiveRecord::Base
  has_many :contact_groups
  has_many :contacts, through: :contact_groups
end
