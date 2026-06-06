class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, foreign_key: true
      t.string :title, null: false
      t.text :notes
      t.string :status, null: false, default: "inbox"
      t.string :priority, null: false, default: "normal"
      t.datetime :due_at
      t.datetime :completed_at

      t.timestamps
    end

    add_index :tasks, %i[user_id status due_at]
  end
end
