class User < ApplicationRecord
  include BuildSafeCode

  has_many :teams
  has_many :projects
  has_many :user_teams
  has_many :user_projects

  before_save :ensure_user_key

  private

  def ensure_user_key
    if user_key.blank?
      self.user_key = generate_code
    end
  end
end
