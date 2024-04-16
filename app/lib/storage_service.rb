class StorageService
  require 'securerandom'

  attr_reader :bucket, :object, :object_key

  def initialize(bucket:, object_key: default_object_key)
    @bucket = bucket
    @object_key = object_key
    @object = create_object
  end

  def download_url
    object.public_url
  end

  def presigned_url
    object.presigned_url(:put)
  end

  private

  def create_object
    bucket.object(object_key)
  end

  def default_object_key
    SecureRandom.hex(10)
  end
end
