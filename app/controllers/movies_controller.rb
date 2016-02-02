class MoviesController < ApplicationController
   def index
=begin 
Sorting by likes/ hates could be done in more elegant-Rubyist way by gathering @movies = Movies.all, and then 
calculating total votes for each one and then sorting by votes through likes_count/ hates_count. But the result 
of that would be many more queries and I wanted to avoid that.
=end
      sort = params[:sort]
      if sort == 'date_added'
         @movies = Movie.all.order(:created_at => :desc) 
      elsif sort == 'like' || sort == 'hate' 
         @movies = Movie.join_votes.order("sum(votes.#{sort}) DESC")
      end
      
      @filter_by = params[:user] || {}
      if @filter_by == {}
         @movies ||= Movie.all
      else
         @movies ||= Movie.where(user_id: @filter_by).join_votes.order("sum(votes.hate) DESC")
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
