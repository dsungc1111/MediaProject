//
//  SearchCollectionViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/29/24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let poster = UIImageView()
    
  
    override func configureHierarchy() {
        contentView.addSubview(poster)
    }
    override func configureLayout() {
        poster.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    
}