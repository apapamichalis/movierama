class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, length: { minimum: 2 }
  has_many :movies #don't want to delete movies when a user unregisters. Noone will be able to edit them though
  has_many :votes, dependent: :destroy
end
