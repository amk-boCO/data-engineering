class PurchaseRecord < ActiveRecord::Base
  self.table_name = 'purchases'

  validates :count, presence: true
  validates :customer_id, presence: true
  validates :item_id, presence: true
  validates :merchant_id, presence: true
end
