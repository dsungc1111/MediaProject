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
        view.backgroundColor = .orange
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.2
        view.addShadow(location: .top)
        view.addShadow(location: .bottom)
        view.addShadow(location: .right)
        view.addShadow(location: .left)
        return view
    }()
    var posterImageView = {
       let poster = UIImageView()
        poster.backgroundColor = .systemTeal
        return poster
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
    }
    
    
    
    
    
    
}

