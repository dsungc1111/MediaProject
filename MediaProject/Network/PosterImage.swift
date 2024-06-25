//
//  Poster.swift
//  MediaProject
//
//  Created by 최대성 on 6/25/24.
//

import Foundation
import Alamofire

struct PosterPath: Decodable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}

struct Poster: Decodable {
    let posters: [PosterPath]
}

class NetworkPosterImage {
    
    
    static var shared = NetworkPosterImage()
    
    private init() {}
    
    
    
    func callPosterImages(completionHandler: @escaping ([PosterPath]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/940721/images"
        
        let param: Parameters = [
            "include_image_language" : "en",
            "api_key" : APIKey.movieKey
        ]
        
        AF.request(url, parameters: param).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.posters)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

