class FilesController < ApplicationController
  def upload
    flash[:error] = 'Please provide a file' and redirect_to root_path and return if params[:upload].nil?

    purchase_ids = FileUploader.new(params[:upload][:file]).process!
    @gross_revenue = PurchaseQuery.gross_revenue(purchase_ids)
  end
end
