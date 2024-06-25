//
//  NewworkRecommendMovie.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import Foundation
import Alamofire

class NetworkRecommendMovie {
    
    static var shared = NetworkRecommendMovie()
    
    private init() {}
    
    func callrecommendedMovie(id: Int, completionHandler: @escaping ([MovieResults]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?language=ko-Kr&page=1"

        let header: HTTPHeaders = ["Authorization" : APIKey.similar, "accept" : "application/json" ]

        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Similar.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value.results)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
