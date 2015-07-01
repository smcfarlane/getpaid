class Partner < ActiveRecord::Base
  belongs_to :organization

  belongs_to :vendors, foreign_key: :vendor_id, class_name: 'Organization'
  belongs_to :vendor_clients, foreign_key: :organization_id, class_name: 'Organization'

  belongs_to :clients, foreign_key: :client_id, class_name: 'Organization'
  belongs_to :managers, foreign_key: :organization_id, class_name: 'Organization'
end
