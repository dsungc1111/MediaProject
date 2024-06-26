//
//  DetailInfoViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/26/24.
//

import UIKit
import SnapKit

class DetailInfoViewController: BaseViewController {
    
    static var getContents = Results(posterPath: "", title: "", releaseDate: "", backdropPath: "", voteAverage: 0.0, id: 0)
    
    
    let imageView = UIImageView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = DetailInfoViewController.getContents
            .title
        
    }
    
    override func configureHierarchy() {
        view.addSubview(imageView)
    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
    }
    override func configureView() {
        let string = "https://image.tmdb.org/t/p/w500\(DetailInfoViewController.getContents.backdropPath)"
        let url = URL(string: string)
        imageView.kf.setImage(with: url)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
    }
    
    
}
