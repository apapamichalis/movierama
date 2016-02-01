class Movie < ActiveRecord::Base
   belongs_to :user
   has_many :votes, dependent: :destroy
   validates :title, length: { minimum: 1 }
   
   # TODO cache the results
   
   def likes_count   
      votes.sum(:like)
   end
   
   def hates_count
      votes.sum(:hate)
   end
end
