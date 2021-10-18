class FriendRequestsController < ApplicationController

    def create
        @request = FriendRequest.new(request_params)
        if @request.save!
            flash[:alert] = 'successfully sent request'
            redirect_to profiles_path
        else
            flash[:alert] = 'error sending request'
            redirect_to profiles_path
        end
    end

    def accept
        @request = FriendRequest.find_by(sent_from: params[:sent_from], sent_to: params[:sent_to])
        if @request.update(status: 'accepted')
            flash[:alert] = 'request accepted'
            redirect_to friend_requests_path
        else
            flash[:alert] = 'error accepting request'
            redirect_to friend_requests_path
        end
    end

    def decline
        @request = FriendRequest.find_by(sent_from: params[:sent_from], sent_to: params[:sent_to])
        if @request.destroy!
            flash[:alert] = 'request declined'
            redirect_to friend_requests_path
        else
            flash[:alert] = 'error declining request'
            redirect_to friend_requests_path
        end
    end

    def show
        @requests = FriendRequest.where(sent_to: current_user.id, status: 'requested')
    end

    private

    def request_params
        params.require(:request).permit(:sent_from, :sent_to, :status)
    end

end
