class User < ActiveRecord::Base
  belongs_to :organization
  belongs_to :account
  has_many :addresses, as: :addressable
  has_many :phones, as: :callable
  has_many :emails, as: :emailable
end
