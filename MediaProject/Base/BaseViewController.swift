//
//  BaseViewController.swift
//  MediaProject
//
//  Created by 최대성 on 6/26/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    
}
