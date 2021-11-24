class Match < ApplicationRecord
  validates :owner, presence: true
end
