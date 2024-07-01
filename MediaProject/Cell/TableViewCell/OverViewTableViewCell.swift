//
//  CreditTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/27/24.
//

import UIKit
import SnapKit


final class OverViewTableViewCell: BaseTableViewCell {

    var isMore: Bool = false
    let overviewLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    lazy var moreButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(moreButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    @objc func moreButtonTapped(sender: UIButton) {
        isMore.toggle()
        moreButton.setImage(isMore ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"), for: .normal)
        overviewLabel.numberOfLines = isMore ? 0 : 2
        invalidateIntrinsicContentSize()
    }
    override func configureHierarchy() {
        contentView.addSubview(overviewLabel)
        contentView.addSubview(moreButton)
    }
    override func configureLayout() {
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(30)
        }
        moreButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
