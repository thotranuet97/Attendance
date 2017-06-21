class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.date :date
      t.time :time_in
      t.time :time_out
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :attendances, [:user_id, :date], unique: true
  end
end
