require 'spec_helper'

describe PurchaseRecord do
  let(:purchase_attrs) { {customer_id: 1, item_id: 2, merchant_id: 3, count: 6} }

  it 'can be persisted' do
    item = PurchaseRecord.create(purchase_attrs)
    expect(item).to be_persisted
  end

  it 'requires a customer_id' do
    item = PurchaseRecord.create(purchase_attrs.except(:customer_id))
    expect(item).to have(1).error_on(:customer_id)
  end

  it 'requires a item_id' do
    item = PurchaseRecord.create(purchase_attrs.except(:item_id))
    expect(item).to have(1).error_on(:item_id)
  end

  it 'requires a merchant_id' do
    item = PurchaseRecord.create(purchase_attrs.except(:merchant_id))
    expect(item).to have(1).error_on(:merchant_id)
  end

  it 'requires a count' do
    item = PurchaseRecord.create(purchase_attrs.except(:count))
    expect(item).to have(1).error_on(:count)
  end
end
