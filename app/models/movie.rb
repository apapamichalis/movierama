class Movie < ActiveRecord::Base
   belongs_to :user
   validates :title, length: { minimum: 1 }
end
