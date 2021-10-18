class FriendRequest < ApplicationRecord

    belongs_to :to, class_name: 'User', foreign_key: 'sent_from'
    belongs_to :from, class_name: 'User', foreign_key: 'sent_to'

    attribute :status, :string, default: 'requested'

    #cant send a friend request to self
    validate :sent_to_self

    def find_user(user_id)
        return User.find_by(id: user_id).username
    end

    def sent_to_self
        if self.sent_to == self.sent_from
            return true
        end
    end
    
end
