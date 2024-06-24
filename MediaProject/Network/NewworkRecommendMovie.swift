//
//  NewworkRecommendMovie.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation
import Alamofire

class NewworkRecommendMovie {
    
    static var shared = NewworkRecommendMovie()
    
    private init() {}
    
    func callrecommendedMovie(id: Int, page: Int, completionHandler: @escaping (Result<[RecMovie], Error>) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?language=ko-Kr&page%20=\(page)"

        let header: HTTPHeaders = ["Authorization" : APIKey.similar, "accept" : "application/json" ]

        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: RecommendedMovie.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value.results))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
}
