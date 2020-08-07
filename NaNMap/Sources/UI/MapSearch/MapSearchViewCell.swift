//
//  MapSearchViewCell.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/08/07.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class MapSearchViewCell: UITableViewCell {
    @IBOutlet weak var facilityNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func display(facilityName: String) {
        facilityNameLabel.text = facilityName
    }
    
    func display(location: String?) {
        let location = location ?? " - "
        locationLabel.text = location
    }
}
