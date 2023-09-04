class UploadsController < ApplicationController
  def storage_service_urls
    storage = StorageService.new
    render json: { presigned_url: storage.presigned_url, download_url: storage.download_url }
  end
end
