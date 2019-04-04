//
//  BusinessAPIManager.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/25/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import Foundation

class BusinessAPIManager {
    
    static let baseUrl = "https://data.cityofnewyork.us/resource/9w7m-hzhe.json"
    
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    // WILL LIMIT AMOUNT OF TOTAL REQUEST MADE TO 50.
    func getBusinesses(completion: @escaping ([Business]?, Error?) -> ()) {
       // let url = URL(string: (BusinessAPIManager.baseUrl)+"?$where=grade%20in('C')&$limit=50")!
        let url = URL(string: (BusinessAPIManager.baseUrl)+"?$limit=50")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject]
    
                let  businessDictionaries = dataDictionary
                
                let businesses = Business.businesses(dictionaries: businessDictionaries as! [[String : Any]])
                completion(businesses, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    // WILL BE USED TO FILTER THE RESULT BY NAME.
    func getSearchResult(search: String, completion: @escaping ([Business]?, Error?) -> ()){
        let Name = search;
        let inParam = "?$where=dba in("+Name+")";
        let url = URL(string: BusinessAPIManager.baseUrl+inParam)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will be used to search for specific address.
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject]
                
                let  businessDictionaries = dataDictionary
                
                let businesses = Business.businesses(dictionaries: businessDictionaries as! [[String : Any]])
                completion(businesses, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()

    }
 
}
