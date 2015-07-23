class AddUserFieldsToArticleAndComment < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.references :user, index: true, foreign_key: true
    end
    change_table :comments do |t|
      t.references :user, index: true, foreign_key: true
    end
  end
end
