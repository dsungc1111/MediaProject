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



class TrendViewController: BaseViewController {
    
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSet()
        configureNavigationButton()
        getTrend()
    }
    @objc func searchButtonTapped() {
        let vc = ContentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    func getTrend() {
        DispatchQueue.global().async {
            NetworkTrend.shared.callTrendMovie(api: .TrendMovie) { movie, error in
                if let error = error {
                    print(error)
                } else {
                    guard let movie = movie else { return }
                    Data.contents = movie
                    let group = DispatchGroup()
                    for item in movie{
                        group.enter()
                        DispatchQueue.global().async {
                            NetworkTrend.shared.callCreditRequest(api: .Credit(id: item.id)) { credit, error in
                                if let error = error {
                                    print(error)
                                    group.leave()
                                } else {
                                    guard let credit = credit else { return }
                                    for j in 0..<movie.count {
                                        if credit.id == movie[j].id {
                                            Data.list.append(credit)
                                        }
                                    }
                                }
                                group.leave()
                            }
                        }
                        group.notify(queue: .main) {
                            self.tableView.reloadData()
                        }
                    }
                }
                
            }
        }
    }
    func tableViewSet() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }
    func configureNavigationButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        let data = Data.contents[indexPath.row]
        cell.configureCell(data: data)
        cell.descriptionLabel.text = ""
        for i in 0..<Data.list.count {
            cell.descriptionLabel.text! +=  "\(Data.list[indexPath.row].cast[i].name), "
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreditViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        CreditViewController.getContents = Data.contents[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

