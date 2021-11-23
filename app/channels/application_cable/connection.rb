module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      verified_user = find_verified_user
      self.current_user = verified_user.user_name
      logger.add_tags 'ActionCable', verified_user.email
    end

    protected

    def find_verified_user
      if (verified_user = env['warden'].user)
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
