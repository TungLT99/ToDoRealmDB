//
//  ExtensionDate.swift
//  ToDoCoreData
//
//  Created by TungLe on 30/04/2023.
//

import Foundation
extension Date {
    func DateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
}
