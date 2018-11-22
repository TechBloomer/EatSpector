//
//  BusinessCell.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/24/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var businessImg: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var gradingLabel: UILabel!
    @IBOutlet weak var record_dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var business: Business!{
        willSet(business){
            self.businessNameLabel.text = business.name
            self.categoriesLabel.text = business.categories
            self.gradingLabel.text = business.grading
            self.record_dateLabel.text = business.record_date
            let building = business.building_number + " "
            let street = business.street + " "
            let boro = business.boro + " "
            let zipcode = business.zipcode
            self.addressLabel.text = building+street+boro+zipcode
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
