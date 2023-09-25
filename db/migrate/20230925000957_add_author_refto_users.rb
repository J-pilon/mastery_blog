class AddAuthorReftoUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :author, foreign_key: true
  end
end
