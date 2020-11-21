//
//  Models.swift
//  movieapp
//
//  Created by Onipko Jenya on 10.11.2020.
//

import Foundation

struct MovieResults: Codable {
    let adult: Bool
    let overview: String
    let release_date: String
    let id: Int
    let title: String
    let poster_path: String?
}

struct Movie: Codable {
    var results: [MovieResults]
}
