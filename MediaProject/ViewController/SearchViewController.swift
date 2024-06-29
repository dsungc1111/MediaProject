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
    var page = 1
    
    static func CollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 30
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing + cellSpacing)
        layout.itemSize = CGSize(width: width/2 - sectionSpacing, height: width/2 + cellSpacing)
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
        collectionView.prefetchDataSource = self
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
        NetworkTrend.shared.trending(api: .Search(query: text, page: page), model: Content.self) { movie, error in
            if let error = error {
                print(error)
            }
            guard let movie = movie else { return }
            if self.page == 1 {
                self.contents.results = movie.results
            } else {
                self.contents.results.append(contentsOf: movie.results)
            }
            self.collectionView.reloadData()
            if self.page == 1 {
               self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
           }
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        page = 1
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

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if contents.results.count - 6 == item.row {
                guard let text = searchBar.text else { return }
                page += 1
                getSearchMovie(text: text)
            }
        }
    }
}
