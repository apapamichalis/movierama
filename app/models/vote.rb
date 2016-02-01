class Vote < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  # only one vote per user per movie
  validates :movie, uniqueness: { scope: :user  }
  validates :user,  uniqueness: { scope: :movie }
  
end
