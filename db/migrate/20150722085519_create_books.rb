class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author_name
      t.string :book_name
      t.date :book_date
      t.timestamps null: false
    end
  end
end
