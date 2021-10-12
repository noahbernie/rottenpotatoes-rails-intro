class Movie < ActiveRecord::Base
  attr_accessor :all_ratings
  attr_accessor :ratings_to_show
  
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    if ratings_list is nil 
      Movie.all
    else 
      Movie.where(rating in ratings_list)
    end 
  end
  
  def self.all_ratings()
    @all_ratings = ['G','PG','PG-13','R']
  end 
  
  def self.set_ratings_to_show(hash)
    if hash == nil 
      @ratings_to_show = []
    else 
      @ratings_to_show = []
      hash.each do |key, value|
       @ratings_to_show.append(key) 
      end 
    end 
  end 
end
