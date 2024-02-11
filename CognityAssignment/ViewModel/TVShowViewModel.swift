//
//  TVShowViewModel.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 9/3/23.
//

import Foundation
class TVShowViewModel{
    var apishared:APIManager!
    init(){
        apishared = APIManager.shared
    }
    func fetchTVShows() async -> [TVModel]{
        return await apishared.fetchShows()
    }
  
    
}
