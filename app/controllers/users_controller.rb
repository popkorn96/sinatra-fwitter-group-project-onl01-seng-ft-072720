class UsersController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "secret"
    end
    get "/signup" do
        if !Helpers.is_logged_in?(session)
            erb :"/users/signup"
        else 
            redirect "/users/tweets"
        end
      end
      
    post "/signup" do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/signup"
        else 
            @user = User.new(username: params[:username], email: params[:email], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect "/users/tweets"
        end
    end
    
    get "/login" do 
        if !Helpers.is_logged_in?(session)
            erb :"/users/login"
        else 
            redirect "/tweets"
        end
    end
    
    post "/login" do
    @session = session
        user = User.find_by(username: params[:username])  # Take name to get users  name
        if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
        end
        redirect "/signup"
    end
    get "/logout" do
        if !Helpers.is_logged_in?(session)
            redirect "/login"
        else
            session.clear
            redirect "/login"
        end
    end
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end

end
