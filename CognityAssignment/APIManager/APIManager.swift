//
//  APIManager.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 9/3/23.
//

import Foundation
import Alamofire
import SwiftyJSON
class APIManager{
    static let shared = APIManager()
    func fetchShows(completion:@escaping (([TVModel])->())){
        let url = URL(string: API_URL)!
        let urlRequest = URLRequest(url: url)
        AF.request(urlRequest).responseData {  dataResponse in
            do{
                var result: [TVModel] = []
                let json = try JSON(data: dataResponse.data!)
                for value in 0..<json.count{
                    result.append(TVModel(name: json[value]["name"].stringValue, rating: String(format:"%.2f",json[value]["rating"]["average"].doubleValue), thumbnail: json[value]["image"]["medium"].stringValue))
                }
                completion(result)
            }
            catch{
                debugPrint("something went wrong!!!")
            }
        }.resume()
        
    }
    
}
