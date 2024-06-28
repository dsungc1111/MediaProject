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
    var creditList: [MovieInfo] = []
    var contents: [Results] = []
    var idList: [IDs] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSet()
        configureNavigationButton()
        getTrend()
        getIDs()
    }
    func getIDs() {
        DispatchQueue.global().async {
            NetworkTrend.shared.callMovieIds(api: .genreID) { iDS, error in
                if let error = error {
                    print(error)
                } else {
                    guard let ids = iDS else { return }
                    self.idList = ids
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                
                }
            }
        }
        
    }
    func getTrend() {
        let group = DispatchGroup()

        group.enter() // +1
        
        NetworkTrend.shared.callTrendMovie(api: .TrendMovie) { movie, error in
            if let error = error {
                print(error)
                group.leave() // -1
                return
            }
            
            guard let movie = movie else {
                group.leave() // -1
                return
            }
            
            self.contents = movie
            group.leave() // -1
            
            for item in self.contents {
                group.enter() // +1
                NetworkTrend.shared.callCreditRequest(api: .Credit(id: item.id)) { credit, error in
                    if let error = error {
                        print(error)
                        group.leave() // -1
                        return
                    }
                    
                    guard let credit = credit else {
                        group.leave() // -1
                        return
                    }
                    
                    self.creditList.append(credit)
                    group.leave() // -1
                }
            }
        }

        group.notify(queue: .main) {
                self.tableView.reloadData()
            }
        }

    func tableViewSet() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
    }
    func configureNavigationButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
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
        return contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier, for: indexPath) as! TrendTableViewCell
        let data = contents[indexPath.row]
        cell.configureCell(data: data)
        cell.descriptionLabel.text = ""
        
        if indexPath.row < creditList.count {
                 for i in 0..<creditList[indexPath.row].cast.count {
                     if i != creditList[indexPath.row].cast.count - 1 {
                         cell.descriptionLabel.text! += "\(creditList[indexPath.row].cast[i].name), "
                     } else {
                         cell.descriptionLabel.text! += "\(creditList[indexPath.row].cast[i].name)"
                     }
                 }
             }
        for j in 0..<idList.count {
            if contents[indexPath.row].genreIds[0] == idList[j].id {
                cell.genreLabel.text = "#\(idList[j].name)"
            }
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
        CreditViewController.getContents = contents[indexPath.row]
        CreditViewController.getCredit = creditList[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
