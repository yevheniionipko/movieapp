//
//  BaseService.swift
//  movieapp
//
//  Created by Onipko Jenya on 10.11.2020.
//

import Foundation

public enum BaseService {
  case findMovie(id: String)
  case discoverMovie
}

extension BaseService {
  
  var url: String {
    return "\(ApiConstants.API_URL)"
  }

  var path: URL {
    switch self {
    case .findMovie(let id):
        let path: String = "\(url)/search/movie?api_key=\(ApiConstants.API_KEY)&language=ru-RU&query=\(id)&page=1&include_adult=false"
        return URL(string: path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    case .discoverMovie:
      return URL(string: "\(url)/discover/movie")!
    }
  }

}
