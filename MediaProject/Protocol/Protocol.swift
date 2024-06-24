//
//  File.swift
//  MediaProject
//
//  Created by 최대성 on 6/10/24.
//

import UIKit

protocol ReuseIndentifierProtocol {
    static var identifier: String { get }
}


extension UIViewController: ReuseIndentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIndentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIndentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
