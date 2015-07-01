class Project < ActiveRecord::Base
  has_many :project_orgs
  has_many :organizations, through: :project_orgs
  has_many :invoices, -> {where(active: true)}
  belongs_to :owner, class_name: 'Organization'
end
