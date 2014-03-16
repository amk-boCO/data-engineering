require 'csv'

class FileUploader
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def process!
    purchase_ids = []

    CSV.new(file.read, headers: true, col_sep: "\t").each do |row|
      customer_name = row[0]
      item_description = row[1]
      item_price = row[2]
      purchase_count = row[3]
      merchant_address = row[4]
      merchant_name = row[5]

      purchase = PurchaseRecord.create!({
        count: purchase_count,
        customer_id: customer(customer_name).id,
        item_id: item(item_description, item_price).id,
        merchant_id: merchant(merchant_address, merchant_name).id
      })
      purchase_ids << purchase.id
    end

    purchase_ids
  end

private

  def customer(customer_name)
    CustomerRecord.find_or_create_by!(name: customer_name)
  end

  def item(description, price)
    ItemRecord.find_or_create_by!(description: description, price: price)
  end

  def merchant(address, name)
    MerchantRecord.find_or_create_by!(address: address, name: name)
  end
end
