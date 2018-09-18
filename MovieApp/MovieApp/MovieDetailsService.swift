//
//  MovieDetailsService.swift
//  MovieApp
//
//  Created by Adarsh Shrivastava on 19/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import Foundation

protocol MovieDetailsDelegate{
    func movieDetails(movieDetails:MovieDetails)
}


class MovieDetailsService{
    
    var movieDetailsDelagate:MovieDetailsDelegate?
    
    func callMovieDetailsAPI(movieId:Int64){
        let movieIdToString = String(movieId)
        let str = "https://api.themoviedb.org/3/movie/" + movieIdToString + "?api_key=55957fcf3ba81b137f8fc01ac5a31fb5"
        let url = URL(string: str)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else{return}
            guard let movieDetailsData = data else{return}
            guard let movieDetailsJson = try! JSONSerialization.jsonObject(with: movieDetailsData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] else{return}
            var movieDetailsObject  = MovieDetails()
            if let movieDescription = movieDetailsJson["overview"] as? String{
                movieDetailsObject.description = movieDescription as? String
            }
            if let movieTitle = movieDetailsJson["title"] as? String{
                movieDetailsObject.title = movieTitle
            }
            if let moviePosterPath = movieDetailsJson["poster_path"] as? String{
                movieDetailsObject.posterPath = moviePosterPath
            }
            self.movieDetailsDelagate?.movieDetails(movieDetails: movieDetailsObject)
        }
        task.resume()
    }

}
