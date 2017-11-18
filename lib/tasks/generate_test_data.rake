namespace :generate_test_data do
  desc 'generate'
  task users: :environment do
    users = []
    5.times.each do
      user = User.create(nickname: SecureRandom.hex(3), user_key: SecureRandom.uuid.gsub('-', ''), email: "#{SecureRandom.hex(3)}@gmail.com")
      users << user
      puts user.as_json
      puts "token: #{FeedListToken.encode(openid: user.user_key)}"
    end

    team = Team.create(user_id: users.first.id, name: "team_#{SecureRandom.hex(2)}")
    puts team.as_json
    project = Project.create(user_id: users.first.id, name: "project_#{SecureRandom.hex(2)}", team_id: team.id)
    puts project.as_json
  end
end