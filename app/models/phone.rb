class Phone < ActiveRecord::Base
  belongs_to :callable, polymorphic: true
end
