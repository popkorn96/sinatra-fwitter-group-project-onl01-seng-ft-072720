require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secretssss"
  end

  get "/" do
    @session = session
    erb :index
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

get "/tweets" do
  if Helpers.is_logged_in?(session)
    @user = Helpers.current_user(session)
    @tweets = Tweet.all
    erb :"/tweets/index"
  else
    redirect "/login"
  end
end

get "/tweets/new" do
  if !Helpers.is_logged_in?(session)
    redirect "/login"
  else
    @user = Helpers.current_user(session)
    erb :"/tweets/new"
  end
end

post "/tweets" do
  @tweet = Tweet.new(params)
  @user = Helpers.current_user(session)
  if Helpers.is_logged_in?(session) && !@tweet.content.blank? && @tweet.save
      @user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
  elsif !Helpers.is_logged_in?(session)
    redirect "/login"
  else
      redirect "/tweets/new"
  end
end

get "/tweets/:id" do
  if !Helpers.is_logged_in?(session)
    redirect "/login"
  else
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweet"
  end
end

get "/tweets/:id/edit" do
  if !Helpers.is_logged_in?(session)
    redirect "/login"
  end
  @tweet = Tweet.find(params[:id])
  if Helpers.current_user(session).id != @tweet.user_id
    redirect "/tweets"
  end
  erb :"/tweets/edit_tweet"
end

delete "/tweets/:id/delete" do
  @tweet = Tweet.find_by_id(params[:id])

  if Helpers.is_logged_in?(session) && @tweet.user == Helpers.current_user(session)
    @tweet.delete
    redirect "/tweets"
  else
    redirect "/login"
  end
end

get "/logout" do
    if !Helpers.is_logged_in?(session)
        redirect "/login"
    else
        session.clear
        redirect "/login"
    end
end

end
