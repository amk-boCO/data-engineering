require 'spec_helper'

describe MerchantRecord do
  let(:merchant_attrs) { {address: '100 Pearl Street', name: 'Merchant of Honor'} }

  it 'can be persisted' do
    merchant = MerchantRecord.create(merchant_attrs)
    expect(merchant).to be_persisted
  end

  it 'requires a address' do
    merchant = MerchantRecord.create(merchant_attrs.except(:address))
    expect(merchant).to have(1).error_on(:address)
  end

  it 'requires a name' do
    merchant = MerchantRecord.create(merchant_attrs.except(:name))
    expect(merchant).to have(1).error_on(:name)
  end
end
