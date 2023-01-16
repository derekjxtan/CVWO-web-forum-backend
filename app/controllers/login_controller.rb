class LoginController < ApplicationController
    skip_before_action :authenticate_user

    # POST /login
    def create
        # user = User.find_by(username: params[:username], password: params[:password])

        # render json: user, include: ["id", "username", "liked.user", "disliked.user", "saved.user"]
        @user = User.find_by(username: params[:username])
        if @user&.authenticate(params[:password])
            token = JwtToken.encode(user_id: @user.id)
            time = Time.now + 24.hours.to_i
            # render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username }, status: :ok
            # render json: {token: token, user: UserSerializer.new(@user) }, status: :ok
            # maybe just return token, id and username
            render json: {token: token, user: UserSerializer.new(@user) }, status: 200
        else
            render json: {error: 'unauthorized' }, status: :unauthorized
        end
    end
end