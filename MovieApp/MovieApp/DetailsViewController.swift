//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Adarsh Shrivastava on 18/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,MovieDetailsViewModelDelegate {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    var movieId:Int64?
    override func viewDidLoad() {
        super.viewDidLoad()
        let movieDetailViewModelObject = MovieDetailsViewModel()
        movieDetailViewModelObject.movieDetailsviewModelDelegate = self
        movieDetailViewModelObject.callmovieDetailsAPI(movieId: movieId!)

    }

    func getMovieDetails(movieDetails: MovieDetails){
       movieTitle.text = movieDetails.title
        movieDescription.text = movieDetails.description
        let posterPathId = movieDetails.posterPath
        let imagelink = "https://image.tmdb.org/t/p/w780" + posterPathId!
        let url = URL(string: imagelink)
        let imageData = try? Data(contentsOf: url!)
        if let data = imageData{
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: data)
            }
        }
    }
    

   }
