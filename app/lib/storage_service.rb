class StorageService
  require 'securerandom'
  
  attr_reader :bucket_name, :object_key, :bucket

  REGION = ENV["AWS_REGION"]
  ACCESS_KEY_ID = ENV["AWS_ACCESS_KEY_ID"]
  SECRET_ACCESS_KEY = ENV["AWS_SECRET_ACCESS_KEY"]

  def initialize(bucket_name:, bucket:, object_key: default_key)
    @bucket_name = bucket_name
    @bucket = bucket
    @object_key = object_key
  end

  def download_url
    "https://#{bucket_name}.s3.#{REGION}.amazonaws.com/#{object_key}"
  end

  def presigned_url
    url = bucket.object(object_key).presigned_url(:put)
    puts "Created presigned URL: #{url}"
    return URI(url)

  rescue Aws::Errors::ServiceError => e
    puts "Couldn't create presigned URL for #{bucket.name}:#{object_key}. Here's why: #{e.message}"
  end

  def default_key
    SecureRandom.hex(10)
  end
end