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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewSet()
        configureNavigationButton()
        configureHeirarchy()
        configureLayout()
        callRequest()
    }
    
    @objc func searchButtonTapped() {
        let vc = ContentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableViewSet() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
    }
    func configureNavigationButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
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
                    Data.contents = value.results
                    for i in 0..<value.results.count {
                        self.callCreditRequest(id: value.results[i].id)
                    }
                case .failure(let error):
                    self.networkAlert()
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
                    for i in 0...value.id {
                        if id == i {
                            Data.list.append(value)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        let data = Data.contents[indexPath.row]
        cell.configureCell(data: data)
        cell.descriptionLabel.text = ""
        for i in 0..<Data.list[indexPath.row].cast.count {
                cell.descriptionLabel.text! +=  "\(Data.list[indexPath.row].cast[i].name), "
            }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        DetailInfoViewController.getContents = Data.contents[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

