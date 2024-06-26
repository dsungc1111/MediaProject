//
//  Struct.swift
//  MediaProject
//
//  Created by 최대성 on 6/11/24.
//

import UIKit



struct Results: Decodable {
    let posterPath: String
    let title: String?
    let releaseDate: String?
    let backdropPath: String
//    let genre_ids: [Int]
    let voteAverage: Double
//    let overview: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case voteAverage  = "vote_average"
        case id
    }
}

struct Content: Decodable {
    let page: Int
    let results: [Results]
}




struct Info: Decodable {
    let name: String
}

struct MovieInfo: Decodable {
    let id: Int
    let cast: [Info]
}
