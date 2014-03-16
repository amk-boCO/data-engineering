require 'spec_helper'

feature 'Uploading a file' do
  it 'instructs the user' do
    visit '/'

    page.should have_content 'Please upload a tab delimited file'
  end

  it 'displays the total gross revenue of the upload a file' do
    visit '/'

    attach_file 'upload_file', 'spec/fixtures/files/upload_test.tab'
    click_on 'Upload'

    page.should have_content 'Total Amount of Gross Revenue for the uploaded file: $20.00'
  end
end
