class User < ActiveRecord::Base
  belongs_to :organization
  belongs_to :account
  has_many :addresses, as: :addressable
  has_many :phones, as: :callable
  has_many :emails, as: :emailable
  has_many :invites, foreign_key: :inviting_user

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :phones
  accepts_nested_attributes_for :emails
  accepts_nested_attributes_for :organization
end
