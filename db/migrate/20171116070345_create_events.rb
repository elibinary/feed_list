class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :team_id, null: false, comment: '团队 ID'
      t.integer :user_id, null: false, comment: '用户 ID'
      t.integer :project_id, null: false, comment: '项目 ID'
      t.integer :eventable_id, null: false, comment: '事件对象 id'
      t.string :eventable_type, null: false, limit: 191, comment: '事件对象'
      t.string :content, comment: '事件内容'

      t.timestamps

      t.index :team_id
      t.index :user_id
      t.index :project_id
    end
  end
end
