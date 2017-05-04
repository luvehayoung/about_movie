class MoviesController < ApplicationController
    @@api_url='http://www.omdbapi.com/?t='
    def index
        @allMovie = Movie.all
    end
    
    def search
        require('json')
        require('open-uri')
        #여기까지
        
        #forms에서 입력받은 제목을 가져온다
        @movie_title=params[:title]
        
        
        #api_url끝에 제목을 붙여서 주소를 새로 만들어준다
        movie_search=@@api_url+@movie_title.to_s
        
        open_page=open(movie_search)
        movie_info = open_page.read
        movie_hash = JSON.parse(movie_info)
        
        @newMovie = Movie.new
        @newMovie.title = movie_hash["Title"]
        @newMovie.released = movie_hash["Released"]
        @newMovie.poster = movie_hash["Poster"]
        @newMovie.save
    end
    
    def show
        @thisMovie = Movie.find(params[:id])
    end
    
    def edit
        @editMovie = Movie.find(params[:id])
    end
    def update
        require('json')
        require('open-uri')
        
        movie_search=@@api_url+params[:title].to_s
        
        open_page=open(movie_search)
        movie_info = open_page.read
        movie_hash = JSON.parse(movie_info) 
        
        @updateMovie = Movie.find(params[:id])
        @updateMovie.title = movie_hash["Title"]
        @updateMovie.released = movie_hash["Released"]
        @updateMovie.poster = movie_hash["Poster"]
        @updateMovie.save
    
    end
    
    def delete
        @deleteMovie = Movie.find(params[:id])
        @deleteMovie.destroy
        redirect_to '/index'
    end
    
end
