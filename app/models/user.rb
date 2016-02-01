class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, length: { minimum: 2 }, uniqueness: true
  has_many :movies, dependent: :destroy # if I don't destroy them, they will become unmanageable
  has_many :votes, dependent: :destroy
end
