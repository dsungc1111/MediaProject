//
//  SearchViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/29/24.
//

import UIKit
import IQKeyboardManagerSwift
import SnapKit


class SearchViewController: BaseViewController {

    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout())
 
    static func CollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 30
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing + cellSpacing)
        layout.itemSize = CGSize(width: width/2 - sectionSpacing, height: width/2)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    var contents = Content(page: 0, results: [])
    var searchText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func getSearchMovie(text : String) {
        NetworkTrend.shared.trending(api: .Search(query: text), model: Content.self) { movie, error in
            if let error = error {
                print(error)
            }
            guard let movie = movie else { return }
            self.contents = movie
            self.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        getSearchMovie(text: text)
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contents.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return SearchCollectionViewCell() }
                
        let string = "https://image.tmdb.org/t/p/w500\(contents.results[indexPath.item].posterPath)"
        let url = URL(string: string)
        cell.poster.kf.setImage(with: url)
                
        return cell
    }
    
    
}
