class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nickname, limit: 191, comment: '昵称'
      t.string :avatar_url, comment: '头像'
      t.string :user_key, null: false, limit: 50, comment: 'UserKey'
      t.string :email, null: false, limit: 191, comment: '邮箱'

      t.timestamps

      t.index :user_key, unique: true
      t.index :email, unique: true
    end
  end
end
