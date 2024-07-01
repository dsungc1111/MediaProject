//
//  VideoCollectionViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 7/1/24.
//

import UIKit
import SnapKit

final class VideoCollectionViewCell: BaseCollectionViewCell {
    
    let titleButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.isEnabled = false
        return btn
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleButton)
    }
    override func configureLayout() {
        titleButton.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
    }
    
}
