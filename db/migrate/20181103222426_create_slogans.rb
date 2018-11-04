class CreateSlogans < ActiveRecord::Migration[5.2]
  def change
    create_table :slogans do |t|
      t.string :title

      t.timestamps
    end
  end
end
