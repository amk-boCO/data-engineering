require 'spec_helper'

describe ItemRecord do
  let(:item_attrs) { {description: 'The best item evar', price: 17.40} }

  it 'can be persisted' do
    item = ItemRecord.create(item_attrs)
    expect(item).to be_persisted
  end

  it 'requires a description' do
    item = ItemRecord.create(item_attrs.except(:description))
    expect(item).to have(1).error_on(:description)
  end

  it 'requires a price' do
    item = ItemRecord.create(item_attrs.except(:price))
    expect(item).to have(1).error_on(:price)
  end
end
