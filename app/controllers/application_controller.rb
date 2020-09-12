require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end
  get "/" do
    erb :"/home/index"
  end
  get "/signup" do
      erb :"/home/signup"
      redirect "/users/tweets"
  end
  post "/signup" do 
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      # session[:user_id] = @user.id
      redirect to "/users/tweets"
    else params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/home/signup"
    end
  end
  get "/login" do 
    erb :"/home/login"
    redirect to "/users/tweets"
  end
    
end
