class MerchantRecord < ActiveRecord::Base
  self.table_name = 'merchants'

  validates :address, presence: true
  validates :name, presence: true
end
