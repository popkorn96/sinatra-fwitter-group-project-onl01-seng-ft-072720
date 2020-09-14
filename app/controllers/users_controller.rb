class UsersController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "secret"
    end

    # get "/signup" do
    #     if !is_logged_in?
    #         erb :"/users/signup"
    #     else 
    #         redirect "/users/tweets"
    #     end
    # end

    # post "/signup" do 
    #     @session = session
    #     if params[:username] == "" || params[:email] == "" || params[:password] == ""
    #         redirect to "/signup"
    #     else 
    #         @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    #         @user.save
    #         session[:user_id] = @user.id
    #         redirect to "/tweets"
    #     end
    # end

    # get "/login" do 
    #     if !is_logged_in?
    #         erb :"/users/login"
    #     else 
    #         redirect "/tweets"
    #     end
    # end
    # post "/login" do
    #     user = User.find_by(:username => params[:username])  # Take name to get users  name
    #     if user && user.authenticate(params[:password])
    #       session[:user_id] = user.id
    #       redirect to "/tweets/tweets"
    #     else
    #       redirect to "/signup"
    #     end
    # end
    # get '/logout' do
    #     if !is_logged_in?
    #         redirect to "/"
    #     else
    #         session.clear
    #         redirect to "/users/login"
    #     end
    # end
      

end
