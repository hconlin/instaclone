# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: {case_sensitive: false}

  has_many :photos, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  has_many :friend_requests, dependent: :destroy

  def exists_or_is_self?(current_user_id, user_id)
    if FriendRequest.find_by(sent_from: current_user_id, sent_to: user_id) != nil ||  
    FriendRequest.find_by(sent_from: user_id, sent_to: current_user_id) != nil || 
    current_user_id == user_id
        return true
    end
    return false
  end

end
