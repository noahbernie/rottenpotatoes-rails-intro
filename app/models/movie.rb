class Movie < ActiveRecord::Base
  attr_accessor :all_ratings
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
  end
  
  def self.all_ratings()
    @all_ratings = ['G','PG','PG-13','R']
  end 
end