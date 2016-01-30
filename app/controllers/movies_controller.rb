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
      @movies = Movie.all.order(ordering)
   end
   
   def show
      @movie = Movie.find(params[:id])
   end
   
   def new
   end
   
   def create
      @movie = Movie.new(movie_params)
      @movie.save
      redirect_to @movie
   end
   
   def edit
      @movie = Movie.find(params[:id])
   end
   
   def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      
      redirect_to movie_path(@movie)
  end
   
   def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      redirect_to movies_path
   end
   
   private
   
      def movie_params
         params.require(:movie).permit(:title, :text)
      end
   
end
