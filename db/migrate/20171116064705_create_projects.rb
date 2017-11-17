class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false, limit: 191
      t.string :safe_code, null: false, limit: 191
      t.integer :user_id, null: false, comment: '用户 ID'
      t.string :description

      t.timestamps

      t.index :safe_code, unique: true
      t.index :user_id
    end
  end
end
