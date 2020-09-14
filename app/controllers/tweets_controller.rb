class TweetsController < ApplicationController
    configure do 
        enable :sessions
        set :session_secret, "fwitter_secretssss"
    end
    # get "/tweets" do
    #     if !logged_in?
    #         redirect to "/login"   
    #     end
    #     @users = current_user
    #     @tweets = Tweet.all
    #     erb :"/tweets/tweets"
    # end
    # post "/tweets" do
    #     @tweet = Tweet.new(params)
    #     @user = Helpers.current_user(session)
    #     if logged_in? && !@tweet.content.blank? && @tweet.save
    #         @user.tweets << @tweet
    #         redirect to "/tweets/#{@tweet.id}"
    #     else
    #         redirect "/tweets/new"
    #     end
    # end
    
end
