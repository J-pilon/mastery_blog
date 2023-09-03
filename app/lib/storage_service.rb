class StorageService
  require 'securerandom'
  
  attr_reader :bucket, :object, :object_key

  def initialize(bucket:, object_key: default_object_key)
    @bucket = bucket
    @object_key = object_key
    @object = create_object
  end

  def download_url
    return if !object
    object.public_url
  end

  def presigned_url
    return if !object
    object.presigned_url(:put)
  end

  private

  def create_object
    return if !bucket
    bucket.object(object_key)
  end
  
  def default_object_key
    SecureRandom.hex(10)
  end
end