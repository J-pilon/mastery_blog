class AddStateToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :state, :integer, default: 0
  end
end
