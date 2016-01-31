class Vote < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  validates :movie, uniqueness: { scope: :user  }
  validates :user,  uniqueness: { scope: :movie }
end
