class CreateBadgeAwards < ActiveRecord::Migration[8.0]
  def change
    create_table :badge_awards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :badge_key, null: false
      t.datetime :awarded_at, null: false

      t.timestamps
    end

    add_index :badge_awards, %i[user_id badge_key], unique: true
  end
end
