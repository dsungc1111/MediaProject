//
//  TMDBManager.swift
//  MediaProject
//
//  Created by 최대성 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBManager {
    
    case SimilarMovie(id: Int)
    case RecommendedMovie(id: Int)
    case Posters(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URL {
        switch self {
        case .SimilarMovie(let id):
            return URL(string: baseURL + "/movie/\(id)/similar?language=ko-Kr&page=1")!
        case .RecommendedMovie(let id):
            return URL(string: baseURL + "/movie/\(id)/recommendations?language=ko-Kr&page=1")!
        case .Posters(let id):
            return URL(string: baseURL + "/movie/\(id)/images")!
        }
    }
    
        
    var method: HTTPMethod {
        return .get
    }
        
    var parameter: Parameters {
        switch self {
        case .SimilarMovie(let id), .RecommendedMovie(let id):
            return ["language" : "ko-Kr", "page" : "1", "id" : id, "api_key" : APIKey.movieKey]
        case .Posters(let id):
            return ["include_image_language" : "en", "api_key" : APIKey.movieKey, "id" : id]
        }
    }
}
