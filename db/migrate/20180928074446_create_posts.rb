class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :body
      t.string :state
      t.string :link
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
