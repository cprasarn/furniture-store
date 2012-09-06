class UserRole < ActiveRecord::Base
  attr_accessible :id, :role_id, :user_id
end
