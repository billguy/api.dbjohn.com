class CreatePics < ActiveRecord::Migration[5.2]
  def change
    create_table :pics do |t|
      t.boolean :published, default: false
      t.string :title
      t.string :permalink
      t.text :caption
      t.string :location
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
