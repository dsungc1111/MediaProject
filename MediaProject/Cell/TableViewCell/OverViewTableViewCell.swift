//
//  CreditTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/27/24.
//

import UIKit
import SnapKit


class OverViewTableViewCell: BaseTableViewCell {

    let overviewLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(overviewLabel)
    }
    override func configureLayout() {
        overviewLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
}
