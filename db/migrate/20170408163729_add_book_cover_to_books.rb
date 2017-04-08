class AddBookCoverToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :book_cover, :string
  end
end
