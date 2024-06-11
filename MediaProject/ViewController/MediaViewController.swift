//
//  ViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

// UserDefaults 관련 로직 객체
// UserDefaultsManager
// Data Transfer Object

struct Content: Decodable {
    let page: Int
    let results: [Results]
}


struct Results: Decodable {
    let poster_path: String
    //let original_title: String
    //let release_date: String
//    let original_title: String
//    let media_type: String
    let title: String?
    let release_date: String?
    let genre_ids: [Int]
    let vote_average: Double
    let overview: String
}


class MediaViewController: UIViewController {

    var tableView = UITableView()
    
    var contents: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableViewSet()
        configureNavigationButton()
        configureHeirarchy()
        configureLayout()
        
      
        callRequest()
        
        
    }
    
    @objc func detailButtonTapped() {
        //let nav = UINavigationController(rootViewController: MediaViewController())
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableViewSet() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
        
    }
    
    func configureNavigationButton() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
    }
    
    func configureHeirarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.movieKey)"
        
        AF.request(url, method: .get)
            .responseDecodable(of: Content.self) { response in
                       switch response.result {
                       case .success(let value):
                           self.contents = value.results
                    
                           self.tableView.reloadData()
                       case .failure(let error):
                           print(error)
                    }
                   }
        
    }

    
}


extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
       
        let string = "https://image.tmdb.org/t/p/w500\(contents[indexPath.row].poster_path)"
        let url = URL(string: string)
        cell.posterImageView.kf.setImage(with: url)
        cell.posterImageView.contentMode = .scaleToFill
        
       
        if let release = contents[indexPath.row].release_date {
            let date = DateFormatter.changeDate.date(from: release)
            let dateString = DateFormatter.changeString.string(from: date!)
            cell.dateLabel.text = dateString
            
        }
        
        
        cell.rateNumberLabel.text = "\(String(format: "%.1f", contents[indexPath.row].vote_average))"
        cell.titleLabel.text = contents[indexPath.row].title
        cell.descriptionLabel.text = contents[indexPath.row].overview
        cell.detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

