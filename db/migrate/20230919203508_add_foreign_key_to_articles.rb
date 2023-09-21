class AddForeignKeyToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :profile
  end
end
