//
//  Struct.swift
//  MediaProject
//
//  Created by 최대성 on 6/11/24.
//

import UIKit

struct Content: Decodable {
    let page: Int
    let results: [Results]
}


struct Results: Decodable {
    let poster_path: String
    let title: String?
    let release_date: String?
//    let genre_ids: [Int]
    let vote_average: Double
//    let overview: String
    let id: Int
}


struct MovieInfo: Decodable {
    let id: Int
    let cast: [Info]
}

struct Info: Decodable {
    let name: String
}
