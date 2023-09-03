require 'rails_helper'

RSpec.describe "StorageService" do
  context "with valid params" do
    let(:storage_service) { StorageService.new(bucket: Aws::S3::Bucket.new("foo", stub_responses: true), object_key: "123abc") }

    it "creates a presigned url" do 
      expect(storage_service.presigned_url).to_not eq(nil)
    end
  
    it "creates a download url" do
      expect(storage_service.download_url).to_not eq(nil)
    end
  end

  context "with invalid params" do
    let(:storage_service) { StorageService.new(bucket: nil) }

    it "presigned url is nil" do 
      expect(storage_service.presigned_url).to eq(nil)
    end
  
    it "download url is nil" do
      expect(storage_service.download_url).to eq(nil)
    end
  end
end