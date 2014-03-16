class FilesController < ApplicationController
  def upload
    FileUploader.new(params[:upload][:file]).process!
  end
end
