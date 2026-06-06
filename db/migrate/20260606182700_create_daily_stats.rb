class CreateDailyStats < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_stats do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :completed_count, null: false, default: 0
      t.integer :xp_total, null: false, default: 0

      t.timestamps
    end

    add_index :daily_stats, %i[user_id date], unique: true
  end
end
