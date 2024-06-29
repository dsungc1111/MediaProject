//
//  ContentCollectionViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }

}
