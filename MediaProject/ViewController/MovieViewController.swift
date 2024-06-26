//
//  MovieViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/12/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

struct Movie: Decodable {
    let page: Int
    var results: [MoviewDetail]
    let total_pages: Int
    let total_results: Int
    
    
}

struct MoviewDetail: Decodable {
    let poster_path: String?
    let title: String
}

class MovieViewController: UIViewController {
    
    var list: [MoviewDetail] = []
    var page = 1
    
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    static func UICollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: width/2)
        layout.scrollDirection = .vertical
        //        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        return layout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "영화 스크롤"
        collectionView.prefetchDataSource = self
        collectionViewSet()
        configureHierarchy()
        configureLayout()
        callRequest()
        
    }
    
    func collectionViewSet() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        view.backgroundColor = .white
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func callRequest() {
        let url =
        "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey.movieKey)&query=String&include_adult=false&language=en-US&page=\(page)"
        
        AF.request(url).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let value):
                if self.page == 1{
                    self.list = value.results
                } else {
                    self.list.append(contentsOf: value.results)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        
        let string = "https://image.tmdb.org/t/p/w500\(list[indexPath.row].poster_path ?? "/xaTVWUrPbGM4SgrLOaaWLeUEafI.jpg")"
        
        
        let url = URL(string: string)
        cell.poster.kf.setImage(with: url )
        cell.poster.contentMode = .scaleToFill
        
        return cell
    }
    
    
    
    
}


extension MovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if item.row == 3{
                page += 1
                callRequest()
            }
        }
    }
    
    
    
    
    
}
