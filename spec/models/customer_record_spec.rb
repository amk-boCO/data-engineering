require 'spec_helper'

describe CustomerRecord do
  let(:customer_attrs) { {name: 'Testy McCustomer'} }

  it 'can be persisted' do
    customer = CustomerRecord.create(customer_attrs)
    expect(customer).to be_persisted
  end

  it 'requirs a customer name' do
    customer = CustomerRecord.create(customer_attrs.except(:name))
    expect(customer).to have(1).error_on(:name)
  end
end
