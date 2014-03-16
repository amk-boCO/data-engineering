require 'spec_helper'

describe FileUploader do

  describe '.new' do
    let(:test_file) { double }

    it 'initializes with a file' do
      file_uploader = FileUploader.new(test_file)
      file_uploader.file.should == test_file
    end
  end

  describe '#process!' do
    let(:test_file) do
      ActionDispatch::Http::UploadedFile.new({
        filename: 'upload_test.tab',
        type: 'text/csv',
        tempfile: File.new("#{Rails.root}/spec/fixtures/files/upload_test.tab")
      })
    end

    describe 'normalizing data' do
      let(:customer) { double(id: 1) }
      let(:item) { double(id: 20) }
      let(:merchant) { double(id: 33) }

      before { PurchaseRecord.stub(:create!) }

      it 'creates records for customers' do
        expect(CustomerRecord).to receive(:find_or_create_by!).with({name: 'Snake Plissken'}).
          once.and_return(customer)

        FileUploader.new(test_file).process!
      end

      it 'creates records for items' do
        expect(ItemRecord).to receive(:find_or_create_by!).
          with({description: '$10 off $20 of food', price: '10.0'}).once.and_return(item)

        FileUploader.new(test_file).process!
      end

      it 'creates records for merchants' do
        expect(MerchantRecord).to receive(:find_or_create_by!).
          with({address: '987 Fake St', name: "Bob's Pizza"}).once.and_return(merchant)

        FileUploader.new(test_file).process!
      end
    end

    it 'produces a record of purchases' do
      expect {FileUploader.new(test_file).process!}.to change{PurchaseRecord.count}.from(0).to(1)
    end
  end
end
