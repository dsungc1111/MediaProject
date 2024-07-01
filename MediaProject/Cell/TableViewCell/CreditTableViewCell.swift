//
//  CreditTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/27/24.
//

import UIKit
import SnapKit

final class CreditTableViewCell: BaseTableViewCell {

    let profileImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .lightGray
        return image
    }()
    let realName = {
        let name = UILabel()
        name.font = .boldSystemFont(ofSize: 15)
        name.text = "dfdsfds"
        return name
    }()
    let characterName = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 13)
        name.textColor = .lightGray
        return name
    }()
    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(realName)
        contentView.addSubview(characterName)
    }
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(60)
        }
        realName.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(30)
        }
        characterName.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(realName.snp.bottom).offset(10)
        }
        
    }
    func configureCell(data: Int) {
        let string = "https://image.tmdb.org/t/p/w500\(CreditViewController.getCredit.cast[data].profilePath ?? "")"
        let url = URL(string: string)
        profileImageView.kf.setImage(with: url)
        realName.text = CreditViewController.getCredit.cast[data].name
        characterName.text = CreditViewController.getCredit.cast[data].character
    }

}
