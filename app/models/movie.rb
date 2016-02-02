class Movie < ActiveRecord::Base
   belongs_to :user
   has_many :votes, dependent: :destroy
   validates :title, length: { minimum: 1 }
   
   scope :join_votes_on_movies, -> {
      joins("left join votes on movies.id = votes.movie_id").
      group("movies.id")
   }
=begin 
    The results can be either cached or the movie can have a likes column and a hates column.
    This could lead to problems though and this is why it has been avoided.
    Maybe, if we were to use the above mentioned columns, on each user/movie destroy, we should
    re-count the likes and hates for all movies. On vote.destroy, we should just decrement by 1.
    Since destroy is called rarely (in comparison to create or view (index/show -- even update))
    this could lead to benefits performance-wise, but is not the safe path to follow for an
    assignment like this. If I had the time I would be building both solutions for comparison.
=end

   # TODO cache the results
   def likes_count   
      votes.sum(:like)
   end
   
   def hates_count
      votes.sum(:hate)
   end
end
