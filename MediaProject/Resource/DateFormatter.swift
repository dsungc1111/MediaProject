//
//  DateFormatter.swift
//  MediaProject
//
//  Created by 최대성 on 6/25/24.
//

import Foundation



class DateChange {
    
    static let shared = DateChange()
    
    private init() {}
    
    // date > String
    private let dateFormatter = DateFormatter()
    
    func dateToString(date: Date) -> String {
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        return dateFormatter.string(from: date)
    }
    
    // String > date
    func stringToDate(string: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
}
