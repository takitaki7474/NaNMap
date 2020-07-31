//
//  ClassLocationViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/30.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit
import MapKit

protocol ClassLocationView: class {
    func loadMap(title: String, coordinate: (Double, Double)?)
}

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
        classLocationPresenter.view = self
        classLocationPresenter.loadClassLocation()
    }
}

extension ClassLocationViewController: ClassLocationView {
    func loadMap(title: String, coordinate: (Double, Double)?) {
        if let coordinate = coordinate {
            let point = MKPointAnnotation()
            point.title = title
            point.coordinate = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
            mapView.addAnnotation(point)
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            mapView.region = MKCoordinateRegion(center: point.coordinate, span: span)
        }
    }
}
