class Movie < ActiveRecord::Base
  
  def self.with_ratings(ratings_list, column)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    if ratings_list == []
      if column.eql? "Title"
        Movie.all.order(:title)
      elsif column.eql? "Release Date"
        Movie.all.order(:release_date)
      else 
        Movie.all
      end 
    else 
      if column.eql? "Title"
        Movie.where(rating: ratings_list).order(:title)
      elsif column.eql? "Release Date"
        Movie.where(rating: ratings_list).order(:release_date)
      else 
        Movie.where(rating: ratings_list)
      end 
    end 
  end
  
  def self.all_ratings()
    ['G','PG','PG-13','R']
  end 
  
  def self.set_ratings_to_show(hash)
    if hash == nil 
      []
    else 
      ratings_to_show = []
      hash.each do |key, value|
       ratings_to_show.append(key) 
      end 
      ratings_to_show
    end 
  end 
end
