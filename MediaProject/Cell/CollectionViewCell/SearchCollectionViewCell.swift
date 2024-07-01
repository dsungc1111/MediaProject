//
//  SearchCollectionViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/29/24.
//

import UIKit
import SnapKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let poster =  {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
  
    override func configureHierarchy() {
        contentView.addSubview(poster)
    }
    override func configureLayout() {
        poster.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    
}
