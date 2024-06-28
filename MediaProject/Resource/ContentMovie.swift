//
//  SimilarMovie.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation

enum GetError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}


struct MovieResults: Decodable {
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}

struct Similar: Decodable {
    let results: [MovieResults]
}


struct FilePath: Decodable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}

struct Poster: Decodable {
    let posters: [FilePath]
}
