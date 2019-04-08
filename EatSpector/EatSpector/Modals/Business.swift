//
//  Business.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/24/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import Foundation

class Business {
    var name: String
    var categories: String
    var grading: String
    var building_number: String
    var street: String
    var boro: String
    var zipcode: String
    var address: String = ""
    var record_date: String
    var critical_flag: String
    var inspection_date: String
    var inspection_type: String
    var phone: String
    var score: String
    var violation_code: String
    var violation_Description: String
    
    
    
    /*:
     # Initiate a dictionary
     */
    init(dictionary: [String:Any]){
        name = dictionary["dba"] as? String ?? "no name"
        categories = dictionary["cuisine_description"] as? String ?? "no category"
        grading = dictionary["grade"] as? String ?? "Not Available"
        building_number = dictionary["building"] as? String ?? "building number not available"
        street = dictionary["street"] as? String ?? "street not available"
        boro = dictionary["boro"] as? String ?? "boro not available"
        zipcode = dictionary["zipcode"] as? String ?? "zipcode not available"
        record_date = dictionary["record_date"] as? String ?? "no date"
        critical_flag = dictionary["critical_flag"] as? String ?? "data not available"
        inspection_date  = dictionary["inspection_date"] as? String ?? "data not available"
        inspection_type  = dictionary["inspection_type"] as? String ?? "data not available"
        phone  = dictionary["phone"] as? String ?? "data not available"
        score  = dictionary["score"] as? String ?? "data not available"
        violation_code  = dictionary["violation_code"] as? String ?? "data not available"
        violation_Description  = dictionary["violation_description"] as? String ?? "data not available"
    }
    
    
    
    /*:
     # Create a collection of dictionaries with business data
     */
    class func businesses(dictionaries: [[String: Any]]) -> [Business]{
        var businesses: [Business] = []
        for dictionary in dictionaries {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
}
