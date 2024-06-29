//
//  DetailInfoViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/26/24.
//

import UIKit
import SnapKit

class CreditViewController: BaseViewController {
    
    static var getContents = Results(posterPath: "", title: "", releaseDate: "", backdropPath: "", genreIds: [], voteAverage: 0.0, overview: "", id: 0)
    static var getCredit = MovieInfo(id: 0, cast: [])
    var titleOfMovie = ""
    let imageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    let movieTitle = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 24)
        title.textColor = .white
        title.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        title.layer.cornerRadius = 5
        title.clipsToBounds = true
        return title
    }()
    let posterImage = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        return image
    }()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
        tableViewSetting()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More", style: .plain, target: self, action: #selector(moreButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black

    }
    @objc func moreButtonTapped() {
        let vc = ContentViewController()
        vc.themeLabel.text = Self.getContents.title ?? "제목"
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CreditTableViewCell.self, forCellReuseIdentifier: CreditTableViewCell.identifier)
        tableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: OverViewTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(movieTitle)
        view.addSubview(posterImage)
        view.addSubview(tableView)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(35)
        }
        posterImage.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(120)
            make.width.equalTo(90)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
      
    }
    override func configureView() {
        let string = "https://image.tmdb.org/t/p/w500\(Self.getContents.backdropPath ?? "")"
        var url = URL(string: string)
        imageView.kf.setImage(with: url)
        movieTitle.text = "  \(Self.getContents.title ?? "제목")  "
        let posterString = "https://image.tmdb.org/t/p/w500\(Self.getContents.posterPath ?? "")"
        url = URL(string: posterString)
        posterImage.kf.setImage(with: url)
    }
}
extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return Self.getCredit.cast.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        } else {
            return "Cast"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier, for: indexPath) as? OverViewTableViewCell else { return OverViewTableViewCell() }
            cell.overviewLabel.text = Self.getContents.overview
            cell.selectionStyle = .none
            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier, for: indexPath) as? CreditTableViewCell else { return CreditTableViewCell() }
            cell.configureCell(data: indexPath.row)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 100
        }
        return UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
