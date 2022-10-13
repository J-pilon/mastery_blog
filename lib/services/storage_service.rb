class StorageService
    require 'securerandom'

    def initialize(client: init_s3_client, filename: SecureRandom.hex(10))
        @client = client
        @filename = filename
    end

    def download_url
        "https://#{ENV['AWS_S3_BUCKET']}.s3.#{ENV['AWS_S3_REGION']}.amazonaws.com/#{@filename}"
    end

    def presigned_url
        presigner = Aws::S3::Presigner.new(client: client)
        url, headers = presigner.presigned_request(:put_object, bucket: bucket_name, key: filename)
    end

    private

    def init_s3_client
        Aws::S3::Client.new(
            region: ENV["AWS_REGION"],
            access_key_id: ENV["AWS_ACCESS_KEY_ID"],
            secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
        )
    end

    def bucket_name
        ENV["RAILS_ENV"] == "production" ? ENV["AWS_BUCKET_PROD"] : ENV["AWS_BUCKET_DEV"]
    end
end