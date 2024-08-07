//
//  TMDBManager.swift
//  MediaProject
//
//  Created by 최대성 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBManager {
    
    case Credit(id: Int)
    case TrendMovie
    case SimilarMovie(id: Int)
    case RecommendedMovie(id: Int)
    case Posters(id: Int)
    case genreID
    case Search(query: String, page: Int)
    case Videos(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var endPoint: URL {
        switch self {
        case .SimilarMovie(let id):
            return URL(string: baseURL + "/movie/\(id)/similar")!
        case .RecommendedMovie(let id):
            return URL(string: baseURL + "/movie/\(id)/recommendations")!
        case .Posters(let id):
            return URL(string: baseURL + "/movie/\(id)/images")!
        case .TrendMovie:
            return URL(string: baseURL + "/trending/movie/week")!
        case .Credit(let id):
            return URL(string: baseURL + "/movie/\(id)/credits")!
        case .genreID:
            return URL(string: baseURL + "/genre/movie/list")!
        case .Search:
            return URL(string: baseURL + "/search/movie")!
        case .Videos(let id):
            return URL(string: baseURL + "/movie/\(id)/videos")!
        }
    }
    

    var method: HTTPMethod {
        return .get
    }
        
    var parameter: Parameters {
        switch self {
        case .TrendMovie, .Credit, .genreID:
            return ["language" : "ko-Kr", "api_key" : APIKey.movieKey]
        case .SimilarMovie(let id), .RecommendedMovie(let id):
            return ["language" : "ko-Kr", "page" : "1", "id" : id, "api_key" : APIKey.movieKey]
        case .Posters(let id):
            return ["include_image_language" : "en", "api_key" : APIKey.movieKey, "id" : id]
        case .Search(let query, let page):
            return [ "language" : "ko-Kr", "api_key" : APIKey.movieKey, "query" : query, "page" : page]
        case .Videos(let id):
            return ["api_key" : APIKey.movieKey, "movie_id" : id]
        }
    }
}
