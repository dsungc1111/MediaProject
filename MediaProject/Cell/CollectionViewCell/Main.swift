//
//  MovieCollectionViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/12/24.
//

import UIKit


class MovieCollectionViewCell: UICollectionViewCell {

    let poster = {
       let image = UIImageView()
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(poster)
        poster.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
