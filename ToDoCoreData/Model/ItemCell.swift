//
//  ItemCell.swift
//  ToDoCoreData
//
//  Created by TungLe on 27/04/2023.
//

import Foundation
import RealmSwift
class Item: Object, Encodable {
    @Persisted var title: String = ""
    @Persisted var check: Bool = false
    @Persisted var dateDone: Date?
    
    convenience init(title: String, check: Bool, dateDone: Date? = nil) {
        self.init()
        self.title = title
        self.check = check
        self.dateDone = dateDone
    }
}
