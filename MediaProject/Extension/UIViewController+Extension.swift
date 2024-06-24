//
//  UIViewController+Extension.swift
//  MediaProject
//
//  Created by 최대성 on 6/25/24.
//


import UIKit


extension UIViewController {
    
    func networkAlert() {
        let alert = UIAlertController(title: "네트워크 에러", message: "네트워크를 확인해주세요.", preferredStyle: .alert)
        
        let settingPage = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(settingPage)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
}
