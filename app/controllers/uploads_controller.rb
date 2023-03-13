class UploadsController < ApplicationController
  def presigned_url
    storage_service = StorageService.new(bucket_name: bucket_name, 
                                         bucket: BucketWrapper.create_bucket(name: bucket_name))
    render json: { presigned_url: storage_service.presigned_url, download_url: storage_service.download_url }
  end

  private

  def bucket_name
    ENV["AWS_BUCKET_DEV"]
  end
end
