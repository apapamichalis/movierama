class MoviesController < ApplicationController
   def index
      sort = params[:sort]
      case sort
      when 'date_added'
         ordering, @most_recent = {:created_at => :desc}
      when 'hates'
         ordering, @most_hates = {:created_at => :asc}
      when 'likes'
         ordering, @most_likes = {:created_at => :desc}
      end
      @filter_by = params[:user] || {}
      if @filter_by == {}
         @movies = @movies = Movie.all.order(ordering)
      else
         @movies = Movie.where(user_id: @filter_by).order(ordering) 
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
