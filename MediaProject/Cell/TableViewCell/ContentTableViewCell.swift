//
//  ContentTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import UIKit
import SnapKit

class ContentTableViewCell: BaseTableViewCell {

    let themeLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    override func configureHierarchy() {
        contentView.addSubview(themeLabel)
        contentView.addSubview(collectionView)
    }
    override func configureLayout() {
        themeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(themeLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
