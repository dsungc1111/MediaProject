//
//  DetailViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/11/24.
//

import UIKit
import SnapKit

class SimilarViewController: UIViewController {
    
    let themeLabel = {
        let label = UILabel()
        label.text = "극한직업"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
  
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        view.addSubview(themeLabel)
        view.addSubview(tableView)
    }
    func configureLayout() {
        themeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(themeLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SimilarTableViewCell.self, forCellReuseIdentifier: SimilarTableViewCell.identifier)
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
    }
    
}


extension SimilarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        view.backgroundColor = .white
        label.text = section == 0 ? "비슷한 영화" : "추천 영화"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarTableViewCell.identifier, for: indexPath) as? SimilarTableViewCell else { return SimilarTableViewCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.identifier, for: indexPath) as? RecommendTableViewCell else { return RecommendTableViewCell() }
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalWidth = tableView.bounds.width
        let width = totalWidth / 3 - 20
        return width * 1.5
    }
    
}
