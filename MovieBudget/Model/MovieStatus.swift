//
//  MovieStatus.swift
//  MovieBudget
//
//  Created by West Agile labs on 15/04/23.
//

import Foundation
struct MovieStatus: Decodable {
    let Title: String
    let Director: String
    let Actors: String
    let Released: String
    let Language: String
    let Awards: String
}
