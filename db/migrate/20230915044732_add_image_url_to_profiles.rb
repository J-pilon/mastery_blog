class AddImageUrlToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :image_url, :string
  end
end
