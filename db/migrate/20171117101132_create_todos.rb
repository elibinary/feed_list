class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.integer :user_id, null: false, comment: '用户 ID'
      t.integer :executor_id, comment: '执行者 ID'
      t.integer :project_id, null: false, comment: '项目 ID'
      t.string :safe_code, null: false, limit: 191
      t.string :content
      t.date :deadline
      t.boolean :deleted, null: false, default: false

      t.timestamps

      t.index :user_id
      t.index :executor_id
      t.index :project_id
      t.index :safe_code, unique: true
    end
  end
end
