class CreateUserTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :user_teams do |t|
      t.integer :user_id, null: false, comment: '用户 ID'
      t.integer :team_id, null: false, comment: '团队 ID'
      t.integer :power, null: false, comment: '权限'

      t.timestamps

      t.index :user_id
      t.index :team_id
    end
  end
end
