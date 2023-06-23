//
//  Model.swift
//  Rest API
//
//  Created by mohammadreza on 2/23/1402 AP.
//

import Foundation
struct MoviesData: Decodable{
    let movies: [Movie]
    
    private enum CodingKeys: String,CodingKey {
        case movies = "results"
        
    }
    
}
struct Movie: Decodable {
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    private enum CodingKeys: String, CodingKey {
        case title,overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}
