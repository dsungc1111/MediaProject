//
//  RecommendedMoview.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation

struct RecMovie: Decodable {
    let posterPath: String?
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
    }
}


struct RecommendedMovie: Decodable {
    let page: Int
    let results: [RecMovie]
}
