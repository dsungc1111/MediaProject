//
//  DetailInfoViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/26/24.
//

import UIKit
import SnapKit

class CreditViewController: BaseViewController {
    
    static var getContents = Results(posterPath: "", title: "", releaseDate: "", backdropPath: "", voteAverage: 0.0, id: 0)
    
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
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        title.clipsToBounds = true
        return title
    }()
    let posterImage = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        return image
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
    }
    override func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(movieTitle)
        view.addSubview(posterImage)
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
    }
    override func configureView() {
        let string = "https://image.tmdb.org/t/p/w500\(Self.getContents.backdropPath)"
        var url = URL(string: string)
        imageView.kf.setImage(with: url)
        
        movieTitle.text = "  \(Self.getContents.title ?? "제목")  "
        
        let posterString = "https://image.tmdb.org/t/p/w500\(Self.getContents.posterPath)"
        url = URL(string: string)
        posterImage.kf.setImage(with: url)
    }
    
    
}
