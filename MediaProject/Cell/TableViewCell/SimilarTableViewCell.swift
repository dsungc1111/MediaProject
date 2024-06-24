//
//  ContentTableViewCell.swift
//  MediaProject
//
//  Created by 최대성 on 6/24/24.
//

import UIKit
import SnapKit

class SimilarTableViewCell: UITableViewCell {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing*2 + cellSpacing*2)
        layout.itemSize = CGSize(width: width/3, height: width / 3 * 1.5)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    var similarPosterLink: [String] = []
    var page = 1
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()
        configureHeirarchy()
        configureLayout()
        callRequestSimilarMovie()
//        callRequestRecMovie()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SimilarCollectionViewCell.self, forCellWithReuseIdentifier: SimilarCollectionViewCell.identifier)
    }
    
    func configureHeirarchy() {
        contentView.addSubview(collectionView)
    }
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
            
        }
    }
    
    func callRequestSimilarMovie() {
        for i in 0..<Data.list.count {
            NetworkSimilarMovie.shared.callSimilarMovie(id: Data.list[i].id, page: page) {result in
                switch result {
                case .success(let posters):
                    let string = "https://image.tmdb.org/t/p/w500\(posters[i].posterPath ?? "")"
                    self.similarPosterLink.append(string)
                    self.collectionView.reloadData()
                case .failure(_):
                    print("error")
                }
            }
        }
    }
}
extension SimilarTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarPosterLink.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.identifier, for: indexPath) as? SimilarCollectionViewCell else { return SimilarCollectionViewCell() }
        
        
            let url = URL(string: similarPosterLink[indexPath.row])
            cell.imageView.kf.setImage(with: url)
     
        
       
        return cell
    }
    
    
}
