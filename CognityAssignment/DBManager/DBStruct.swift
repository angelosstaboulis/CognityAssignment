//
//  DBStruct.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 12/3/23.
//

import Foundation
import RealmSwift
class DBStruct:Object{
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name: String
    @Persisted var ratings: String
    @Persisted var thumb:String
    convenience init(id:Int,name:String,ratings:String,thumb:String) {
        self.init()
        self.id = id
        self.name = name
        self.ratings = ratings
        self.thumb = thumb
    }
}
