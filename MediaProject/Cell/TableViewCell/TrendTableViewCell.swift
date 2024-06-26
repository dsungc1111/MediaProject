//
//  MediaTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/10/24.
//

import UIKit
import SnapKit


class TrendTableViewCell: UITableViewCell {

     var dateLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    var genreLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    var shadowView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.addShadow(location: .top)
        view.addShadow(location: .bottom)
        view.addShadow(location: .right)
        view.addShadow(location: .left)
        return view
    }()
    var posterView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    var posterImageView = {
        let poster = UIImageView()
        poster.layer.cornerRadius = 10
        poster.layer.masksToBounds = true
        poster.contentMode = .scaleAspectFill
        poster.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return poster
    }()
    var rateLabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.text = "평점"
        return label
    }()
    var rateNumberLabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    let descriptionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    let detailButton = {
        var button = UIButton()
        button.setTitle("자세히 보기", for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(shadowView)
        contentView.addSubview(posterView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(rateLabel)
        contentView.addSubview(rateNumberLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(detailButton)
    }
    func configureLayout() {
       
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(contentView.snp.leading).inset(30)
            make.width.equalTo(100)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).inset(20)
            make.width.equalTo(100)
        }
        shadowView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(25)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(22)
        }
        posterView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.top)
            make.horizontalEdges.equalTo(posterView.snp.horizontalEdges)
            make.bottom.equalTo(posterView.snp.bottom).inset(120)
        }
        rateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom).inset(10)
            make.leading.equalTo(posterImageView.snp.leading).inset(10)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        rateNumberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom).inset(10)
            make.leading.equalTo(rateLabel.snp.trailing)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(posterImageView.snp.horizontalEdges).inset(10)
            make.height.equalTo(30)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.horizontalEdges.equalTo(posterImageView.snp.horizontalEdges).inset(10)
            make.height.equalTo(20)
        }
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(posterImageView.snp.horizontalEdges).inset(20)
            make.bottom.equalTo(posterView.snp.bottom).inset(5)
        }
    }
    func configureCell(data: Results) {
        let string = "https://image.tmdb.org/t/p/w500\(data.posterPath)"
        let url = URL(string: string)
        posterImageView.kf.setImage(with: url)
        
        if let releaseDate = data.releaseDate {
            guard let convertDate = DateChange.shared.stringToDate(string: releaseDate) else { return  }
            let convertString = DateChange.shared.dateToString(date: convertDate)
            dateLabel.text = convertString
        }
        rateNumberLabel.text = "\(String(format: "%.1f", data.voteAverage))"
        titleLabel.text = data.title
    }
    

}

