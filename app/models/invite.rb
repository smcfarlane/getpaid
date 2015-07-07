class Invite < ActiveRecord::Base
  belongs_to :organization
  belongs_to :inviting_user, foreign_key: :inviting_user, class_name: 'User'
end
