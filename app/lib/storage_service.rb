class StorageService
  require 'securerandom'

  REGION = ENV["AWS_REGION"]
  ACCESS_KEY_ID = ENV["AWS_ACCESS_KEY_ID"]
  SECRET_ACCESS_KEY = ENV["AWS_SECRET_ACCESS_KEY"]

  def initialize(client: init_s3_client, filename: SecureRandom.hex(10))
    @client = client
    @filename = filename
  end

  def download_url
    "https://#{bucket_name}.s3.#{REGION}.amazonaws.com/#{@filename}"
  end

  def presigned_url
    presigner = Aws::S3::Presigner.new(client: @client)
    url, _ = presigner.presigned_request(:put_object, bucket: bucket_name, key: @filename)
    url
  end

  private

  def init_s3_client
    Aws::S3::Client.new(
      region: REGION,
      access_key_id: ACCESS_KEY_ID,
      secret_access_key: SECRET_ACCESS_KEY
    )
  end

  def bucket_name
    ENV["RAILS_ENV"] == "production" ? ENV["AWS_BUCKET_PROD"] : ENV["AWS_BUCKET_DEV"]
  end
end