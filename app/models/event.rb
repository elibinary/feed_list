class Event < ApplicationRecord
  belongs_to :eventable, polymorphic: true
  belongs_to :user
  belongs_to :team
  belongs_to :project
end
