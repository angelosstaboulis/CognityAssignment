//
//  TVShowViewModel.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 9/3/23.
//

import Foundation
protocol TVSHowProtocol:AnyObject{
    var result:[TVModel]{
        get
        set
    }
}
class TVShowViewModel{
    var apishared:APIManager!
    weak var delegate:TVSHowProtocol?
    init(){
        apishared = APIManager.shared
    }
    func fetchTVShow(){
        apishared.fetchShows { array in
            self.delegate?.result = array
        }
    }
}
