//
//  BaseTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/27/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureCell() {}
    

}
