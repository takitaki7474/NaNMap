//
//  MapSearchViewCell.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/08/07.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class MapSearchViewCell: UITableViewCell {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var subInfoLabel: UILabel!
    func display(locationName: String) {
        locationNameLabel.text = locationName
    }
    
    func display(subInfo: String?) {
        var subInfo = subInfo ?? " - "
        if subInfo == "" { subInfo = " - " }
        subInfoLabel.text = subInfo
    }
}
