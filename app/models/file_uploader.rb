require 'csv'

class FileUploader
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def process!
    CSV.new(file.read, headers: true, col_sep: "\t").each do |row|
      customer_name = row[0]
      item_description = row[1]
      item_price = row[2]
      purchase_count = row[3]
      merchant_address = row[4]
      merchant_name = row[5]

      customer = CustomerRecord.find_or_create_by!(name: customer_name)
      item = ItemRecord.find_or_create_by!(description: item_description, price: item_price)
      merchant = MerchantRecord.find_or_create_by!(address: merchant_address, name: merchant_name)

      PurchaseRecord.create!({count: purchase_count, customer_id: customer.id, item_id: item.id,
        merchant_id: merchant.id})
    end
  end
end

