class AddProfileReferenceToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :profile, foreign_key: true
  end
end
