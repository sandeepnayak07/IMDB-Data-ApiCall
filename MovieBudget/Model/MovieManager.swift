//
//  MovieManager.swift
//  MovieBudget
//
//  Created by West Agile labs on 15/04/23.
//
protocol MovieManagerDelegate {
    func didUpdateMovie(movie: String, director: String, actors: String, released: String, language: String, award: String)
    func didFailWithError(error: Error)
    
}
var delegate: MovieManagerDelegate?

import Foundation
struct MovieManager {
    //https://www.omdbapi.com/?i=tt7430722&apikey=d0bd0a9a
    let baseUrl = "https://www.omdbapi.com"
    let apiKey = "d0bd0a9a"
    let IMDB_id = ["tt2631186", "tt5074352", "tt8948790",  "tt4559006",  "tt2338151", "tt9052870", "tt5312232", "tt0073707", "tt1639426", "tt6473300", "tt1187043", "tt9544034", "tt7392212",  "tt5074352",   "tt6836936", "tt6452574", "tt7430722", "tt4535650", "tt5071886", "tt1833673"]
    
    var delegate: MovieManagerDelegate?
    
    func getMovieName( for IMDB_id: String ) {
        let urlString = "\(baseUrl)/?i=\(IMDB_id)&apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let(title, director, actors, released, language, award) = self.parseJSON(safeData) {
                        self.delegate?.didUpdateMovie(movie: title, director: director, actors: actors, released: released, language: language, award: award)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> (String, String, String, String, String, String)? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(MovieStatus.self, from: data)
            let Title = decodeData.Title
            let Director = decodeData.Director
            let Actors = decodeData.Actors
            let Release = decodeData.Released
            let language = decodeData.Language
            let award = decodeData.Awards
            return (Title, Director, Actors, Release, language, award)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    
    }
}
