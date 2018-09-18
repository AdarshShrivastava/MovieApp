//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Adarsh Shrivastava on 18/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import Foundation

protocol MovieListViewModelDelegate:class{
    func movieListViewModel(movieList:[MovieHome])
}

class HomeViewModel:ServiceDelegate{
    weak var movieListViewModelDelegate:MovieListViewModelDelegate?
    var MovieListObject = MovieService()
    
    
    init(){
        MovieListObject.movieHomeDelegate = self
    }
    
    func callMovieListAPI(){
        MovieListObject.callMovieHomeApi()
    }
    
    func MovieList(movieList: [MovieHome]){
        self.movieListViewModelDelegate?.movieListViewModel(movieList: movieList)
    }
    
    
}
