class UploadsController < ApplicationController
  def storage_service
    storage = StorageService.new(bucket: Aws::S3::Bucket.new(aws_bucket_name))
    render json: { presigned_url: storage.presigned_url, download_url: storage.download_url }
  end

  private

  def aws_bucket_name
    return ENV["AWS_BUCKET_DEV"] if ENV["RAILS_ENV"] == "development"
    return "test" if ENV["RAILS_ENV"] == "test"
  end
end
