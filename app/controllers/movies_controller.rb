class MoviesController < ApplicationController
   def index
      #prefer this method as it produces much less queries than calculating likes for each movie and then ordering movies according to the results
      case params[:sort]
      when 'date_added'
         @movies ||= Movie.all.order(:created_at => :desc) 
      when 'hates'
         @movies = Movie.find_by_sql('SELECT m.*,count(v.hate) FROM Movies m LEFT JOIN Votes v ON m.id=v.movie_id GROUP BY m.id ORDER BY count(v.hate) DESC')
      when 'likes'
         @movies = Movie.find_by_sql('SELECT m.*,count(v.like) FROM Movies m LEFT JOIN Votes v ON m.id=v.movie_id GROUP BY m.id ORDER BY count(v.like) DESC')
      end
      
      @filter_by = params[:user] || {}
      if @filter_by == {}
         @movies ||= Movie.all
      else
         @movies ||= Movie.where(user_id: @filter_by)
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
