class MoviesController < ApplicationController

  before_action :set_ratings
  before_action :set_column
#   before_action set the correct CSS class for each column
  
  def set_ratings
    if params[:ratings]
      @rate = params[:ratings]
      session[:ratings] = params[:ratings]
    elsif params[:q] 
      @rate = session[:ratings]
      @redirect_flag = true 
    else
      @rate = nil
      session[:ratings] = nil
    end 
  end 
  
  def set_column 
    if params[:column]
      session[:column] = params[:column]
      @Highlight = params[:column]
    elsif session[:column]
      @redirect_flag = true 
      @Highlight = session[:column]
    else 
      @Release = ""
      @Title = ""
    end 
  end 
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @ratings_to_show = Movie.set_ratings_to_show(@rate)
    @movies = Movie.with_ratings(@ratings_to_show, @Highlight) 
    if @redirect_flag
      redirect_to movies_path({"ratings" => session[:ratings], "column" => session[:column]})
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