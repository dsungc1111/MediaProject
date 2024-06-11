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



class MediaViewController: UIViewController {

    var tableView = UITableView()
    
//    var contents: [Results] = [] {
//        didSet {
//            for i in 0..<contents.count {
//                callCreditRequest(id: contents[i].id)
//            }
//        }
//    }
    var contents: [Results] = []
    
//    
//    var people: [Int: [Info]] = [:]
    
    var list: [MovieInfo] = []
    
    
    
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
                    //                           for i in 0..<value.results.count {
                    //                               self.callCreditRequest(id: value.results[i].id)
                    //                           }
                    //                           self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    func callCreditRequest(id: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?language=en-US&api_key=\(APIKey.movieKey)"
        AF.request(url, method: .get)
            .responseDecodable(of: MovieInfo.self) { response in
                switch response.result {
                case .success(let value):
                    for _ in 0..<value.cast.count {
                        if id == value.id {
                            self.list.append(value)
                        }
                    }
                   self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        print(list)
        
    }
    
    

    
}


extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        
        let data = contents[indexPath.row]
      
        
        
        
        cell.configureCell(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

