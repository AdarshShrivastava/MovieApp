//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Adarsh Shrivastava on 18/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelDelegate:class{
    func getMovieDetails(movieDetails: MovieDetails)
}

class MovieDetailsViewModel:MovieDetailsDelegate{
    
    weak var movieDetailsviewModelDelegate:MovieDetailsViewModelDelegate?
    var serviceObj:MovieDetailsService?
    
    init(){
        serviceObj = MovieDetailsService()
        serviceObj?.movieDetailsDelagate = self
    }
    
    func callmovieDetailsAPI(movieId:Int64){
        serviceObj?.callMovieDetailsAPI(movieId: movieId)
    }
    
    func movieDetails(movieDetails:MovieDetails){
        self.movieDetailsviewModelDelegate?.getMovieDetails(movieDetails: movieDetails)
     }
    
}
