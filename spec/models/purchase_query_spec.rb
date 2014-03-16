require 'spec_helper'

describe PurchaseQuery do
  describe '.gross_revenue' do
    let(:item) { ItemRecord.create(price: 5.00, description: 'Simply Orange Juice') }
    let(:purchase_one) { PurchaseRecord.create(customer_id: 1, item_id: item.id, merchant_id: 3, count: 3) }
    let(:purchase_two) { PurchaseRecord.create(customer_id: 1, item_id: item.id, merchant_id: 4, count: 1) }

    it 'returns gross revenue given an array of purchase_ids' do
      PurchaseQuery.gross_revenue([purchase_one.id, purchase_two.id]).should == 20.00
    end

    it 'returns $0 when given no purchase_ids' do
      PurchaseQuery.gross_revenue([]).should == 0
    end
  end
end
