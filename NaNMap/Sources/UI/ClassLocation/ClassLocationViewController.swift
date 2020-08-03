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
    
    static func instantiate(presenter: TimeTablePresenter, index: Int) -> ClassLocationViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "classLocationViewController") as! ClassLocationViewController
        controller.classLocationPresenter = ClassLocationViewPresenter(presenter: presenter, index: index)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight: CGFloat = SceneDelegate.statusBarHeight ?? 44.0
        let navigationBarHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 44.0
        let frame = CGRect(x: 5.0, y: statusBarHeight+navigationBarHeight+5.0, width: UIScreen.main.bounds.width-10.0, height: 97)
        let classInformationView = ClassInformationView.instantiate(frame: frame)
        view.addSubview(classInformationView)
        mapView.delegate = self
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
        } else {
            let center = CLLocationCoordinate2D(latitude: 35.149405, longitude: 136.962477)
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            mapView.region = MKCoordinateRegion(center: center, span: span)
            alertUndefinedCoordinate()
        }
    }
}

private extension ClassLocationViewController {
    func alertUndefinedCoordinate() {
        let alert = UIAlertController(title: "講義場所が確認できません.", message: "時間割に戻ります.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension ClassLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKMarkerAnnotationView()
        pin.annotation = annotation
        pin.markerTintColor = UIColor.rgba(red: 250, green: 166, blue: 26)
        return pin
    }
}
