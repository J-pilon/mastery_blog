module BucketWrapper
  def self.create_bucket(name:)
    Aws::S3::Bucket.new(name)
  end
end