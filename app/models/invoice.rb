class Invoice < ActiveRecord::Base
  belongs_to :project
  has_many :line_items
  accepts_nested_attributes_for :line_items
  belongs_to :organization
  belongs_to :to_org, class_name: 'Organization'
end
