class CustomerRecord < ActiveRecord::Base
  self.table_name = 'customers'

  validates :name, presence: true
end
