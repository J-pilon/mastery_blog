class AddForeignKeyConstraintToArticles < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :articles, :categories
  end
end
