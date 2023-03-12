//
//  DBStruct.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 12/3/23.
//

import Foundation
import RealmSwift
class DBStruct:Object{
    @objc dynamic var name:String?
    @objc dynamic var ratings:String?
    @objc dynamic var thumb:String?
    convenience init(name:String,ratings:String,thumb:String) {
        self.init()
        self.name = name
        self.ratings = ratings
        self.thumb = thumb
    }
}
