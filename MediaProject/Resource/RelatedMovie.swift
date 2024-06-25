//
//  SimilarMovie.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation

//struct Results: Decodable {
//    let posterPath: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case posterPath = "poster_path"
//    }
//    
//   
//}
//
//struct Trending: Decodable {
//    let results: [Results]
//}


struct MovieResults: Decodable {
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}

struct Similar: Decodable {
    let results: [MovieResults]
}

