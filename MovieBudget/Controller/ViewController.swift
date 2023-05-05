//
//  ViewController.swift
//  MovieBudget
//
//  Created by West Agile labs on 15/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    var movieManager = MovieManager()

    @IBOutlet weak var MovieNameLabel: UILabel!
    @IBOutlet weak var DirectorNameLabel: UILabel!
    @IBOutlet weak var IMDBIDLabel: UIPickerView!
    @IBOutlet weak var ActorNameLabel: UILabel!
    @IBOutlet weak var ReleaseDateLabel: UILabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    @IBOutlet weak var AwardsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        IMDBIDLabel.dataSource = self
        IMDBIDLabel.delegate = self
        movieManager.delegate = self
    }
}

//Datasource and its methods
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movieManager.IMDB_id.count
    }
}

// Delegate and its methods..
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return movieManager.IMDB_id[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedImdbId = movieManager.IMDB_id[row]
        movieManager.getMovieName(for: selectedImdbId)
    }
}

//MovieManagerDelegate and its methods
extension ViewController: MovieManagerDelegate {
    func didUpdateMovie(movie: String, director: String, actors: String, released: String, language: String, award: String) {
        DispatchQueue.main.async {
            self.MovieNameLabel.text = movie
            self.DirectorNameLabel.text = director
            self.ActorNameLabel.text = actors
            self.ReleaseDateLabel.text = released
            self.LanguageLabel.text = language
            self.AwardsLabel.text = award
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
