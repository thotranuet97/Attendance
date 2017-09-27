class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :full_name
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.boolean :lock, default: false
      t.boolean :first_password, default: true
      t.timestamps null: false
    end
    add_index :users, :user_name, unique: true
    add_index :users, :email, unique: true
  end
end
