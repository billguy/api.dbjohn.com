class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :salt
      t.string :encrypted_password
      t.datetime :last_login_at
      t.datetime :locked_at
      t.string :last_login_ip
      t.integer :failed_attempts, default: 0

      t.timestamps
    end
  end
end
