class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false, comment: '用户 ID'
      t.integer :todo_id, null: false
      t.string :content
      t.boolean :deleted, null: false, default: false

      t.timestamps

      t.index :user_id
      t.index :todo_id
    end
  end
end
