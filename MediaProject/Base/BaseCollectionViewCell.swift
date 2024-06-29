//
//  BaseCollectionViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/29/24.
//

import UIKit


class BaseCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy() {}
    func configureLayout() {}
}
