class AddCategoryReferenceToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :category, index: true
  end
end
