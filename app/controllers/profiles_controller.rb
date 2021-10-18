# frozen_string_literal: true

class ProfilesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @users = if params[:username]&.present?
               User.where(username: params[:username])
             else
               User.limit(20)
             end
  end

  def show
    @user = User.find_by! username: params[:username]
    @friends = FriendRequest.where('status=? AND (sent_to=? OR sent_from=?)', 'accepted', @user.id, @user.id)
  end
end
