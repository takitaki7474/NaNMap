//
//  ClassLocationViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/30.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit
import MapKit

class ClassLocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    static func instantinate() -> ClassLocationViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "classLocationViewController") as! ClassLocationViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
