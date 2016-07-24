class ContactGroup < ActiveRecord::Base
  belongs_to :contact
  belongs_to :group
end
