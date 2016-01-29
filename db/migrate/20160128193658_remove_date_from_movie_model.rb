class RemoveDateFromMovieModel < ActiveRecord::Migration
  def self.up
    remove_column :movies, :date
  end
  
  def self.down
    add_column :movies, :date
  end
end
