class ItemRecord < ActiveRecord::Base
  self.table_name = 'items'

  validates :description, presence: true
  validates :price, presence: true
end
