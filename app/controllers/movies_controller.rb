class MoviesController < ApplicationController

  before_action :sesh_ratings
  before_action :all_ratings
  before_action :set_sort
  before_action :set_column
  before_action :sesh_column
#   after_action :save_ratings
  
#   before_action set the correct CSS class for each column
  
  def save_ratings
    if params[:ratings]
      session[:ratings] = params[:ratings]
    end 
  end 
  
  def sesh_ratings
#     if params[:ratings]
#       @rate = params[:ratings]
#     else 
#       @rate = session[:ratings]
#     end 
    @rate = params[:ratings]
  end 
  
  def sesh_column
    if params[:column]
      session[:column] = params[:column]
    end 
  end 
  
  def set_column 
    if params[:column]
      @Highlight = params[:column]
    elsif session[:column]
      @Highlight = session[:column]
    else 
      @Release = ""
      @Title = ""
    end 
  end 
  
  def set_sort 
    if params[:column] 
      @col = params[:column]
    elsif session[:column]
      @col = session[:column]
    else
      @col = " "
    end 
  end 
  
  def all_ratings
    @all_ratings = Movie.all_ratings
    @ratings_to_show = Movie.set_ratings_to_show(@rate)
  end 
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if @ratings_to_show != nil
      @movies = Movie.with_ratings(@ratings_to_show, @col)
    else 
      @movies = Movie.with_ratings([], @col)
    end 
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end