class MoviesController < ApplicationController
   def index
      @filter_by = params[:user] || {}
      if params[:sort] == 'date_added'
         @movies = Movie.order(:created_at => :desc) 
      elsif params[:sort] == 'like' || params[:sort] == 'hate'
         @movies = Movie.join_votes_on_movies.order("sum(votes.#{params[:sort]}) DESC")
      elsif @filter_by != {}
         @movies = Movie.where(user_id: @filter_by)
      else
         @movies = Movie.all
      end
   end
   
   def show
      @movie = Movie.find(params[:id])
   end
   
   def new
   end
   
   def create
      if current_user && User.find(current_user.id)
         @movie = Movie.new(movie_params)
         @movie.user = current_user
         @movie.save
         redirect_to @movie
      else
         flash[:notice] = "Please login before you can add a new movie"
         redirect_to new_user_session_path
      end
   end
   
   def edit
      @movie = Movie.find(params[:id])
   end
   
   def update
      @movie = Movie.find(params[:id])
      if @movie.user != nil && current_user == @movie.user
         @movie.update_attributes!(movie_params)
         redirect_to movie_path(@movie)
      else
         flash[:notice] = "Only the creator of a movie can edit it!!!"
         redirect_to movies_path
      end
   end
   
   def destroy
      @movie = Movie.find(params[:id])
      if @movie.user != nil && current_user == @movie.user
         @movie.destroy
      else
         flash[:notice] = "Only the creator of a movie can delete it!!!"
      end
      redirect_to movies_path
   end
   
   private
   
   def movie_params
      params.require(:movie).permit(:title, :text)
   end
   
end
