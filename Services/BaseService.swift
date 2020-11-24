//
//  BaseService.swift
//  movieapp
//
//  Created by Onipko Jenya on 10.11.2020.
//

import Foundation

public enum BaseService {
    case findMovie(id: String, page: Int)
    case discoverMovieByGenre(genre: String)
}

extension BaseService {
  
  var url: String {
    return "\(ApiConstants.API_URL)"
  }

  var path: URL {
    switch self {
    case .findMovie(let id, let page):
        let path: String = "\(url)/search/movie?api_key=\(ApiConstants.API_KEY)&language=ru-RU&query=\(id)&page=\(page)&include_adult=false"
        return URL(string: path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    case .discoverMovieByGenre(let genre):
        let path: String = "\(url)/discover/movie?api_key=\(ApiConstants.API_KEY)&with_genres=\(genre)"
        return URL(string: path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
  }

}
