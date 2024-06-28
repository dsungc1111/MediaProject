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
    let genreIds: [Int]
    let voteAverage: Double
    let overview: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case voteAverage  = "vote_average"
        case id
        case overview
        case genreIds = "genre_ids"
    }
}

struct Content: Decodable {
    let page: Int
    let results: [Results]
}

struct Info: Decodable {
    let name: String
    let profilePath: String?
    let character: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}

struct MovieInfo: Decodable {
    let id: Int
    let cast: [Info]
}

struct IDs: Decodable {
    let id: Int
    let name: String
}

struct Genre: Decodable {
    let genres: [IDs]
}
