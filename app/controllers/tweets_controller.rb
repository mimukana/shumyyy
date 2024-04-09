class TweetsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @tweets = Tweet.all
        if params[:tag_ids]
            @tweets = []
            params[:tag_ids].each do |key, value|      
              @tweets += Tag.find_by(name: key).tweets if value == "1"
            end
            @tweets.uniq!
        end
    end

    

    def new
        @tweet = Tweet.new
      end
    
      def create
        tweet = Tweet.new(tweet_params)

        tweet.user_id = current_user.id

        if tweet.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end

      def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new
      end
      
      def edit
        @tweet = Tweet.find(params[:id])
      end

      def update
        tweet = Tweet.find(params[:id])
        if tweet.update(tweet_params)
          redirect_to :action => "index", :id => tweet.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to session[:previous_url]
      end

      def result
        @tweets=Tweet.where(genre: "スポーツ")
        session[:previous_url] = request.referer
      end
    
      def music
        @tweets=Tweet.where(genre: "音楽")
        session[:previous_url] = request.referer
      end

      def cooking
        @tweets=Tweet.where(genre: "料理")
        session[:previous_url] = request.referer
      end

      def anime
        @tweets=Tweet.where(genre: "漫画・アニメ")
        session[:previous_url] = request.referer
      end

      private
      def tweet_params
        params.require(:tweet).permit(:about, :genre, :image, tag_ids: [])

    end

end
