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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
        }
    }


}

extension SearchViewController: UISearchBarDelegate {
    
}
