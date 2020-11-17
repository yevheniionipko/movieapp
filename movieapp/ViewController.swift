//
//  ViewController.swift
//  movieapp
//
//  Created by Onipko Jenya on 10.11.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Requests.findMovie(id: "Avengers")
    }


}

