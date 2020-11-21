//
//  Requests.swift
//  movieapp
//
//  Created by Onipko Jenya on 10.11.2020.
//

import Foundation

struct Requests {
    static func findMovie(id: String, completionHandler: @escaping (Movie?) -> Void) -> Void {
        
        let request = URLRequest(url: BaseService.findMovie(id: id).path)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
              print("Error with fetching films: \(error)")
              return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
              
              print("Error with the response, unexpected status code: \(String(describing: response))")
              return
            }
            
            do {
                let res = try JSONDecoder().decode(Movie.self, from: data!)
                completionHandler(res)

            } catch let error as NSError {
                print(error.debugDescription)
            }
        }).resume()
    }
}
