//
//  MovieService.swift
//  MovieApp
//
//  Created by Adarsh Shrivastava on 18/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import Foundation

protocol ServiceDelegate:class{
    func MovieList(movieList: [MovieHome])
}

class MovieService{
    
    weak var movieHomeDelegate:ServiceDelegate?
    var movieListArray:[MovieHome]?
    func callMovieHomeApi(){
        let movieHomeString = "https://api.themoviedb.org/3/movie/now_playing?api_key=55957fcf3ba81b137f8fc01ac5a31fb5&language=en-US&page=undefined"
        let url = URL(string: movieHomeString)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else{return}
            guard let moviesData = data else{return}
            guard let moviesJson = (try? JSONSerialization.jsonObject(with: moviesData, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            
        }
            //print(json)
           self.movieListArray = [MovieHome]()
            
            if let movieArray = moviesJson["results"] as? NSArray{
                //print(jsonArray[0])
                for movie in movieArray{
                    var movieHomeObject = MovieHome()
                    if let movieDictionary:NSDictionary = movie as? NSDictionary{
                        print(movieDictionary["backdrop_path"]!)
                        movieHomeObject.thumbNailImageLink = (movieDictionary["backdrop_path"]!) as? String
                        movieHomeObject.title = (movieDictionary["original_title"]!) as? String
                    }
                    self.movieListArray?.append(movieHomeObject)
                }
            }
            
            self.movieHomeDelegate?.MovieList(movieList: self.movieListArray!)
        }
        task.resume()
    }
}
