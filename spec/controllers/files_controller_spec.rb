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

      expect(response).to  render_template 'upload'
    end

    it 'calls the file uploader to process the file' do
      file_uploader = double(process!: nil)

      FileUploader.should_receive(:new).with(file).and_return(file_uploader)

      post :upload, upload: {file: file}
    end

    it 'returns the gross revenue' do
      post :upload, upload: {file: file}

      assigns(:gross_revenue).should == 20.0
    end

    describe 'with no file provided' do
      before { post :upload, upload: nil }

      it 'redirects to the home page' do
        expect(response).to redirect_to root_path
      end

      it 'provides a flash error' do
        expect(flash[:error]).to eql 'Please provide a file'
      end
    end
  end
end
