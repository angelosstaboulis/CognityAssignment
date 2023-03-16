//
//  Helper.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 15/3/23.
//

import Foundation
import Network
class Helper:ObservableObject{
    @Published var isOnline = Bool()
    init(){
        checkOnline()
    }
    func checkOnline(){
        let monitor = NWPathMonitor()
        monitor.start(queue: .main)
        monitor.pathUpdateHandler = { [weak self] path in
                        if path.status == .satisfied{
                            self!.isOnline = true
                        }else{
                            self!.isOnline = false
                        }
        }
    }
}
