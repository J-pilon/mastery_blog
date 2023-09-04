class UploadsController < ApplicationController
  def storage_service
    storage = StorageService.new
    render json: { presigned_url: storage.presigned_url, download_url: storage.download_url }
  end
end
