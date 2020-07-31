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
    private var classLocationPresenter: ClassLocationPresenter!
    
    static func instantinate(presenter: TimeTablePresenter, index: Int) -> ClassLocationViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "classLocationViewController") as! ClassLocationViewController
        controller.classLocationPresenter = ClassLocationViewPresenter(presenter: presenter, index: index)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
