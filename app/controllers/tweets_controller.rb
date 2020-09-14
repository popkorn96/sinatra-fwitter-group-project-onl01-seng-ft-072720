class TweetsController < ApplicationController
    configure do 
        enable :sessions
        set :session_secret, "fwitter_secretssss"
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
        @user = Helpers.current_user(session)
        @tweet = Tweet.find(params[:id])
        if !Helpers.is_logged_in?(session)
            redirect "/login"
        elsif @user.id != @tweet.user_id
            redirect "/login"
        # elsif 
        else 
            erb :"/tweets/edit_tweet"
        end
    end
    
    patch "/tweets/:id" do
        tweet = Tweet.find(params[:id])
        if params[:content].empty?
            redirect "/tweets/#{params[:id]}/edit"
        end
        tweet.update(:content => params[:content])
        tweet.save
    
        redirect "/tweets/#{tweet.id}"
    end
    
    post "/tweets/:id/delete" do
        @tweet = Tweet.find_by_id(params[:id])
    
        if Helpers.is_logged_in?(session) && @tweet.user == Helpers.current_user(session)
            @tweet.delete
            redirect "/tweets"
        else
            redirect "/login"
        end
    end
    
end
