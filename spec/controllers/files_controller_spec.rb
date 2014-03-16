require 'spec_helper'

describe FilesController do
  describe 'POST /files/upload' do
    let(:file) do
      ActionDispatch::Http::UploadedFile.new({
        filename: 'upload_test.tab',
        type: 'text/csv',
        tempfile: File.new("#{Rails.root}/spec/fixtures/files/upload_test.tab")
      })
    end

    it 'renders the upload template' do
      post :upload, upload: {file: file}
      response.should render_template 'upload'
    end

    it 'calls the file uploader to process the file' do
      file_uploader = double(process!: nil)
      FileUploader.should_receive(:new).with(file).and_return(file_uploader)
      post :upload, upload: {file: file}
    end

    it 'returns the gross revenue from the XXX model' do
      post :upload, upload: {file: file}
      assigns(:gross_revenue).should == 20.0
    end
  end
end
