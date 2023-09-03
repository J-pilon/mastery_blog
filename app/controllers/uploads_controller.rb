class UploadsController < ApplicationController
  def storage_service_urls
    storage = StorageService.new(bucket: aws_bucket)
    render json: { presigned_url: storage.presigned_url, download_url: storage.download_url }
  end

  private
  
  def aws_bucket
    Aws::S3::Bucket.new(aws_bucket_name)
  end

  def aws_bucket_name
    ENV["RAILS_ENV"] == "production" ? ENV["AWS_BUCKET_PROD"] : ENV["AWS_BUCKET_DEV"]
  end
end
