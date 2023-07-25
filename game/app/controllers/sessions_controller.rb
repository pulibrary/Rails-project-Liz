class SessionsController < ApplicationController
    def new
        render "new"
    end

    def create
        @user= User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            flash[:notice] = "Login successful!"
            # note: another way of doing line below is
            # redirect_to :access_profile, params: {user_id: user.id}
            redirect_to access_profile_path(user_id: @user.id)
        else
            flash.now[:alert] = "Invalid username or password"
            render :new,  status: :unprocessable_entity
        end
    end
end
