class CreateUserProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :user_projects do |t|
      t.integer :user_id, null: false, comment: '用户 ID'
      t.integer :project_id, null: false, comment: '项目 ID'

      t.timestamps

      t.index :user_id
      t.index :project_id
    end
  end
end
