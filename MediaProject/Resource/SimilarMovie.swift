//
//  SimilarMovie.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation

struct ResultsMovie: Decodable {
    let posterPath: String?
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
    }
}


struct Similar: Decodable {
   
    let page: Int
    let results: [ResultsMovie]
    enum CodingKeys: CodingKey {
        case page
        case results
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.results = try container.decodeIfPresent([ResultsMovie].self, forKey: .results) ?? []
    }
}

