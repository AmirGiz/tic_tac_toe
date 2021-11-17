class Match < ApplicationRecord
  def self.create(uuid)
    if !REDIS.get('matches').blank?
      # Get the uuid of the player waiting
      opponent = REDIS.get('matches')

      Game.start(uuid, opponent)
      # Clear the waiting key as no one new is waiting
      REDIS.set('matches', nil)
    else
      REDIS.set('matches', uuid)
    end
  end

  def self.remove(uuid)
    REDIS.set('matches', nil) if uuid == REDIS.get('matches')
  end

  def self.clear_all
    REDIS.del('matches')
  end
end
