class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.boolean :published, default: false
      t.boolean :blog, default: false
      t.string :title
      t.string :permalink
      t.text :content

      t.timestamps
    end
  end
end
