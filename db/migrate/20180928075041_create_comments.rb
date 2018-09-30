class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :com_body
      t.integer :like_count, default: 0
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
