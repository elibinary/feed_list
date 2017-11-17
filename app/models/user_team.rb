class UserTeam < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :team

  enumerize :power, in: { administrator: 1, member: 2, visitor: 3 }, default: :member, scope: true
end
