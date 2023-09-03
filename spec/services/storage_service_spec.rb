require 'rails_helper'

RSpec.describe "StorageService" do
  let(:storage_service) { StorageService.new(bucket: Aws::S3::Bucket.new("foo", stub_responses: true)) }

  it "creates a presigned url" do 
    expect(storage_service.presigned_url).to_not be nil
  end

  it "creates a download url" do
    expect(storage_service.download_url).to_not be nil
  end
end