//
//  GenreDetailViewController.swift
//  movieapp
//
//  Created by Onipko Jenya on 23.11.2020.
//

import Foundation
import UIKit

class GenreDetailViewController: UIViewController {
    var genre: String?
    var movie: Movie = Movie(results: [MovieResults]())
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Requests.getMoviesByGenre(genre: self.genre ?? "") { movie in
            if let mov = movie {
                self.movie = mov
                self.collectionView.reloadData()
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension GenreDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGenreCard", for: indexPath) as? MovieCardCell else {
            fatalError()
        }
        cell.titleLabel.text = self.movie.results[indexPath.row].title
        if let url = URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face/\(self.movie.results[indexPath.row].poster_path ?? "")") {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.image.image = UIImage(data: imageData) ?? UIImage()
                    }
                }
            }).resume()
        }
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
}
