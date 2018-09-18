//
//  ViewController.swift
//  MovieApp
//
//  Created by Adarsh Shrivastava on 18/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,MovieListViewModelDelegate{


    @IBOutlet weak var movieHomeCollectionView: UICollectionView!
    var MovieListViewModelObject = HomeViewModel()
    var movieListArray = [MovieHome]()

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListViewModelObject.callMovieListAPI()
        movieHomeCollectionView.delegate = self
        movieHomeCollectionView.dataSource = self
        MovieListViewModelObject.movieListViewModelDelegate = self
    }
    
    func movieListViewModel(movieList:[MovieHome]){
        for movie in movieList{
        print(movie.thumbNailImageLink!)
        print(movie.title!)
        }
        movieListArray = [MovieHome]()
        movieListArray = movieList
         DispatchQueue.main.async {
            self.movieHomeCollectionView.reloadData()
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return movieListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCollectionCell
        cell.movieTitle.text = movieListArray[indexPath.row].title
        
        let imageUrl = "https://image.tmdb.org/t/p/w780" + movieListArray[indexPath.row].thumbNailImageLink!
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        if let imageData = data{
            DispatchQueue.main.async {
                cell.movieThumbNailImage.image = UIImage(data: imageData)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        detailViewController.movieId = self.movieListArray[indexPath.row].movieId
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

