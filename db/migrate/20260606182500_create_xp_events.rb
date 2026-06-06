class CreateXpEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :xp_events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :points, null: false
      t.string :reason, null: false
      t.datetime :happened_at, null: false

      t.timestamps
    end

    add_index :xp_events, %i[task_id reason], unique: true, where: "task_id IS NOT NULL"
  end
end
