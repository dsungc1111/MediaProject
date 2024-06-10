//
//  MediaTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/10/24.
//

import UIKit




class MediaTableViewCell: UITableViewCell {

     var dateLabel = {
        let label = UILabel()
        label.textColor = .darkGray
         label.font = .systemFont(ofSize: 12)
        label.text = "2012"
        return label
    }()
    var genreLabel = {
        let label = UILabel()
        label.text = "미스테리"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    var posterView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.2
        view.addShadow(location: .top)
        view.addShadow(location: .bottom)
        view.addShadow(location: .right)
        view.addShadow(location: .left)
        view.layer.cornerRadius = 10
        return view
    }()
    var posterImageView = {
        let poster = UIImageView()
        return poster
    }()
    var rateLabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
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
        contentView.addSubview(posterView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(rateLabel)
        contentView.addSubview(rateNumberLabel)
        contentView.addSubview(titleLabel)
    }
    
    func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(contentView.snp.leading).inset(20)
            make.width.equalTo(100)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).inset(20)
            make.width.equalTo(100)
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
            make.leading.equalTo(posterView.snp.leading).inset(10)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    
    
    
    
    
}

