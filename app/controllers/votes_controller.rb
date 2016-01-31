class VotesController < ApplicationController
  
  def new
  end
  
  def create
    if current_user && User.find(current_user.id)
      @movie = Movie.find(params[:movie_id])
      @vote = Vote.new(vote_params)
      @vote.user = current_user
      @vote.movie = Movie.find(params[:movie_id]) #should remove user_id
      case params[:choice]
      when "like"
        @vote.like = 1
        @vote.save
        flash[:notice] = "LIKED!!!"
      when "hate"
        @vote.hate = 1
        @vote.save
      else
        flash[:notice] = "Not the right way to vote!"
      end
    end
    redirect_to movies_path
  end
    
  def destroy
    if current_user && User.find(current_user.id)
      @vote = Vote.find(params[:id])
      if current_user == @vote.user
        @vote.destroy
        flash[:notice] = "Vote deleted"
      end
    else
      flash[:notice] = "Vote not found"
    end
    redirect_to movies_path
  end
  
  private
    def vote_params
      params.permit(:movie_id, :user_id)
    end
end
