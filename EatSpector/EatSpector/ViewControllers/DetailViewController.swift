//
//  DetailViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/18/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import CoreLocation


class DetailViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var busniessImg: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var gradingLabel: UILabel!
    @IBOutlet weak var record_dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var inspectionTypeLabel: UILabel!
    @IBOutlet weak var inspectionDateLabel: UILabel!
    @IBOutlet weak var violationCodeLabel: UILabel!
    @IBOutlet weak var violationDescriptionLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let business = business {
            businessNameLabel.text = business.name
            gradingLabel.text = "Grade : " + business.grading
            record_dateLabel.text = business.record_date
            addressLabel.text = formatAddress(strBuilding: business.building_number, strStreet: business.street, strBoro: business.boro, strZip: business.zipcode)
            phoneLabel.text = "Tel: " + arrangeUSFormat(strPhone: business.phone)
            scoreLabel.text = "Score : " + business.score
            inspectionDateLabel.text = business.inspection_date
            inspectionTypeLabel.text = business.inspection_type
            violationCodeLabel.text = business.violation_code
            violationDescriptionLabel.text = business.violation_Description
        }
    }
    
    //code to format address
    func formatAddress(strBuilding : String, strStreet : String, strBoro : String, strZip : String)-> String{
        let strUpdated = strBuilding + " " + strStreet + ", " + strBoro + ", NY " + strZip
        return strUpdated
    }
    
    
    //code to format phone number
    func arrangeUSFormat(strPhone : String)-> String {
        var strUpdated = strPhone
        if strPhone.characters.count == 10 {
            strUpdated.insert("(", at: strUpdated.startIndex)
            strUpdated.insert(")", at: strUpdated.index(strUpdated.startIndex, offsetBy: 4))
            strUpdated.insert(" ", at: strUpdated.index(strUpdated.startIndex, offsetBy: 5))
            strUpdated.insert("-", at: strUpdated.index(strUpdated.startIndex, offsetBy: 9))
        }
        return strUpdated
    }
    
    //code to go to google map for direction
    @IBAction func getDirectionButton(_ sender: Any) {
        if let business = business {
            let street = business.street
            let trimedStreet = street.replacingOccurrences(of: " ", with: "+")
            let address = business.building_number + "+" + trimedStreet + "+" + business.boro + "+" + business.zipcode
            let baseURLString = "https://www.google.com/maps/search/"
            
            if let url = URL(string: baseURLString + address) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        print("google presses")
    }
    
    //code to go to Yelp for menu
    @IBAction func onClick_GrubHubButton(_ sender: Any) {
        if let business = business {
            let name = business.name
            let trimedName = name.replacingOccurrences(of: " ", with: "-")
            let filteredName = trimedName.replacingOccurrences(of: "&", with: "and")
            
            
            let boro = business.boro
            let trimedBoro = boro.replacingOccurrences(of: " ", with: "-")
            
            let baseURLString = "https://www.yelp.com/biz/"
            
            if let url = URL(string: baseURLString + filteredName + "-" + trimedBoro ) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        print("Yelp button pressed.")
    }
    
    //code to order a ride using Uber
    @IBAction func onClicked_Uber(_ sender: Any) {
        if let business = business {
            let street = business.street
            let trimedStreet = street.replacingOccurrences(of: " ", with: "+")
            let address = business.building_number + "+" + trimedStreet + "+" + business.boro + "+" + business.zipcode
            let baseURLString = "uber://"
            
           /* if let url = URL(string:  "waze://" ) {
                UIApplication.shared.open(url, options: [:])
            }*/
            
            if UIApplication.shared.canOpenURL(URL(string: "map://")!) {
                // Uber is installed. Launch Uber and start navigation
                let urlStr = String(format: "map://")
                UIApplication.shared.open(URL(string: urlStr)!)

                //UIApplication.shared.openURL(URL(string: urlStr)!)
            } else {
                // if Uber is not installed. Launch AppStore to install Uber app
                UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/uber/id368677368?mt=12")!)
            }
        }
        print("Uber button pressed.")
    }
    
    
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     let trailerViewController = segue.destination as! SeamLessViewController
     trailerViewController.business = business
     
     }*/
    
}
