//
//  GenresViewController.swift
//  movieapp
//
//  Created by Onipko Jenya on 22.11.2020.
//

import Foundation
import UIKit

class GenresViewController: UIViewController {
    var genre: String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            switch segue.identifier {
            case "ShowGenreDetail":
                guard let destinationVC = segue.destination as? GenreDetailViewController else { return }
                destinationVC.genre = self.genre
            default: break
            }
        }
    
    func chooseGenre(genre: String) -> Void {
        self.genre = genre
        performSegue(withIdentifier: "ShowGenreDetail", sender: nil)
    }
    
    @IBAction func onTrillerAction(_ sender: UIButton) {
        chooseGenre(genre: "28")
    }
    @IBAction func onRomanticAction(_ sender: UIButton) {
        chooseGenre(genre: "35")
    }
    @IBAction func onDramaAction(_ sender: UIButton) {
        chooseGenre(genre: "18")
    }
}
