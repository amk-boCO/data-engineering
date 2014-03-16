require 'spec_helper'

feature 'Uploading a file' do
  it 'instructs the user' do
    visit '/'

    page.should have_content 'Please upload a tab delimited file'
  end
end
