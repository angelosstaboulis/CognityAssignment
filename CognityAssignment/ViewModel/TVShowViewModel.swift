//
//  TVShowViewModel.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 9/3/23.
//

import Foundation
import Realm
import RealmSwift
class TVShowViewModel{
    var apishared:APIManager!
    var realm:Realm!
    init(){
        apishared = APIManager.shared
        var config = Realm.Configuration()

           config.fileURL = config

               .fileURL!

               .deletingLastPathComponent()

               .appendingPathComponent("cognity.realm")
       
     

           config.schemaVersion = 59

           config.migrationBlock = { _, oldSchemaVersion in

               if oldSchemaVersion < 1 {}
           }
        do{
            realm = try Realm(configuration: config)
        }
        catch{
            
        }
    }
    func fetchTVShows() async -> [TVModel]{
        return await apishared.fetchShows()
    }
    func insertRecord(dbStruct:DBStruct) {
               try! realm?.write{
                   realm?.create(DBStruct.self,value:dbStruct,update: .all)
               }

    }
    func fetchRecords()->Results<DBStruct>{
       
        return (realm?.objects(DBStruct.self))!
    }
    
    
}
