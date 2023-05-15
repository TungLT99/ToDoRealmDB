//
//  RealmDatabase.swift
//  ToDoCoreData
//
//  Created by TungLe on 30/04/2023.
//

import Foundation
import RealmSwift
class RealmDatabase {
    let realm = try! Realm()
    func createData(item: Item) {
        try! realm.write {
            realm.add(item)
        }
    }
    func getAllData() -> [Item] {
        let result = realm.objects(Item.self)
            return Array(result)
    }
    func updateData(oldItem: Item,newItem: Item) {
        try! realm.write {
            oldItem.title = newItem.title
            oldItem.check = newItem.check
            if newItem.check {
                oldItem.dateDone = Date()
            }
            else {
                oldItem.dateDone = nil
            }
        }
    }
    func deleteData(item: Item) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
