//
//  ViewController.swift
//  movieapp
//
//  Created by Onipko Jenya on 10.11.2020.
//

import UIKit

let DEBOUNCE_TIMEOUT: Double = 1 // 1000 ms
let DEFAULT_SEARCH: String = "Мстители"

class ViewController: UIViewController {
    let debouncer = Debouncer(timeInterval: DEBOUNCE_TIMEOUT)
    var movie: Movie = Movie(results: [MovieResults]())
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchMovies(DEFAULT_SEARCH)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    @IBAction func onInput(_ sender: Any) {
        if textField.text == "" {
            self.searchMovies(DEFAULT_SEARCH)
            return
        }
        debouncer.renewInterval()
        debouncer.handler = {
            self.searchMovies(self.textField.text)
        }
    }
    
    func searchMovies(_ id: String?) -> Void {
        Requests.findMovie(id: id ?? "") { movie in
            if let mov = movie {
                DispatchQueue.main.async {
                    self.movie = mov
                    self.collectionView.reloadData()
                    
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCard", for: indexPath) as? MovieCardCell else {
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
