class Team < ApplicationRecord
  include BuildSafeCode

  has_many :user_teams
  has_many :events, as: :eventable

  belongs_to :user

  before_save :ensure_safe_code
end
