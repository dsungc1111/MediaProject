//
//  VideoViewController.swift
//  MediaProject
//
//  Created by 최대성 on 7/1/24.
//

import UIKit
import WebKit

final class VideoViewController: BaseViewController {
    
    private struct Video: Decodable {
        let key : String
        let name : String
    }
    private struct MovieVideo: Decodable {
        let results: [Video]
    }
    private let webView = WKWebView()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    private var videoLink: [Video] = []
    static var movieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        print(Self.movieId)
        callRequest()
    }
    override func configureHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(webView)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func callRequest() {
        NetworkTrend.shared.trending(api: .Videos(id: Self.movieId), model: MovieVideo.self) { link, error in
            if let error = error {
                print(error)
            } else {
                guard let link = link else { return }
                self.videoLink = link.results
                self.collectionView.reloadData()
            }
        }
    }
}


extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoLink.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else { return VideoCollectionViewCell() }
        if videoLink[indexPath.item].key.count != 0 {
            
            let buttonTitle = videoLink[indexPath.item].name
            
            cell.titleButton.setTitle(buttonTitle, for: .normal)
            let string = "https://www.youtube.com/watch?v=" + videoLink[0].key
            if let url = URL(string: string) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        } else {
            print("0개에요")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let string = "https://www.youtube.com/watch?v=" + videoLink[indexPath.item].key
        
        guard let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
