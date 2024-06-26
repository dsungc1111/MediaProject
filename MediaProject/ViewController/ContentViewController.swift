//
//  DetailViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/11/24.
//

import UIKit
import SnapKit


final class ContentViewController: BaseViewController {
    var themeLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    private var posterLink: [[MovieResults]] = [
        [MovieResults(posterPath: "")],
        [MovieResults(posterPath: "")]
    ]
    private let getID = CreditViewController.getContents
    private var posterLink2: [FilePath] = [FilePath(filePath: "")]
    private let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
        getMovies()
    }
    private func getMovies() {
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
            NetworkTrend.shared.trending(api: .SimilarMovie(id: self.getID.id), model: Similar.self) { movie, error in
                if let error = error {
                    print(error)
                } else {
                    guard let movie = movie else { return }
                    self.posterLink[0] = movie.results
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            NetworkTrend.shared.trending(api: .RecommendedMovie(id: self.getID.id), model: Similar.self) { movie, error in
                if let error = error {
                    self.networkAlert()
                } else {
                    guard let movie = movie else { return }
                    self.posterLink[1] = movie.results
                }
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async {
            NetworkTrend.shared.trending(api: .Posters(id: self.getID.id), model: Poster.self) { poster, error in
                if let error = error {
                    self.networkAlert()
                    print(error)
                } else {
                    guard let poster = poster else { return }
                    self.posterLink2 = poster.posters
                }
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    override func configureHierarchy() {
        view.addSubview(themeLabel)
        view.addSubview(tableView)
    }
    override func configureLayout() {
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
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
    }
}
extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posterLink.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell else { return ContentTableViewCell() }
        
        cell.configureCell(data: indexPath)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
extension ContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return posterLink[0].count
        } else if collectionView.tag == 1 {
            return posterLink[1].count
        } else {
            return posterLink2.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { return ContentCollectionViewCell() }
        if collectionView.tag < 2 {
            let data = posterLink[collectionView.tag][indexPath.row]
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.posterPath ?? "")")
            cell.imageView.kf.setImage(with: url)
        }
        if collectionView.tag == 2 {
            let data = posterLink2[indexPath.row]
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.filePath)")
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
    
    
}
