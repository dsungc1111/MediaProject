//
//  Date+Extension.swift
//  MediaProject
//
//  Created by 최대성 on 6/11/24.
//

import UIKit



extension DateFormatter {
    //싼놈
    static let changeString: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter
    }()
    
    
    // 비싼놈
    static let changeDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 2020-08-13 16:30
        return dateFormatter
    }()
}




