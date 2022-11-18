class UploadsController < ApplicationController
  def presigned_url
    ss = StorageService.new

    render json: { presigned_url: ss.presigned_url, download_url: ss.download_url }
  end
end
