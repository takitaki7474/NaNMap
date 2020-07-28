//
//  MapModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/15.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import MapKit
import RealmSwift

class AnnotationObj: Object {
    @objc dynamic var title = ""
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var annotationID = 0
}

protocol MapModelDelegate: class {
    func loadAnnotations(annotations: [AnnotationObj])
    func addAnnotation(annotation: AnnotationObj)
    func reloadMapRegion(at center: (Double, Double))
    func reloadRegion(at region: MKCoordinateRegion)
    func addPin(with pin: MKPointAnnotation)
}

struct Annotation {
    let title: String?
    let coordinate: (longitude: Double, latitude: Double)?
}

final class MapModel {
    weak var delegate: MapModelDelegate?
    var regionCenter: (Double, Double)? {
        didSet {
            delegate?.reloadMapRegion(at: regionCenter!)
        }
    }
    /*
    var annotations: Results<AnnotationObj>? {
        didSet {
            var annotationsList = [AnnotationObj]()
            for obj in annotations! { annotationsList.append(obj) }
            //print(annotationsList)
        }
    }*/
    /*
    var region: MKCoordinateRegion? {
        didSet {
            delegate?.reloadRegion(at: region!)
        }
    }
    var pin: MKPointAnnotation? {
        didSet {
            delegate?.addPin(with: pin!)
        }
    }*/
    
    func loadAnnotations() {
        let realm = try! Realm()
        /*
        try! realm.write {
            realm.deleteAll()
        }*/
        var savedAnnotations = [AnnotationObj]()
        let objs = realm.objects(AnnotationObj.self)
        for obj in objs { savedAnnotations.append(obj) }
        delegate?.loadAnnotations(annotations: savedAnnotations)
    }
    
    private func removeRealmFile() {
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
                print("remove realm file")
            } catch {
                print("remove realm file error")
            }
        }
    }
    /*
    func setUpMapRegion() {
        let centerLatitude: CLLocationDegrees = 35.149405
        let centerLongitude: CLLocationDegrees = 136.962477
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        self.region = MKCoordinateRegion(center: center, span: span)
    }*/
    /*
    func setPin(_ title: String, _ coodinate: (Double, Double)) {
        self.pin = MKPointAnnotation()
        let annotation = Annotation(title: title, coordinate: coodinate)
        let longitude = annotation.coordinate?.0
        let latitude = annotation.coordinate?.1
        self.pin?.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        self.pin?.title = annotation.title
        
        let center = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        self.region = MKCoordinateRegion(center: center, span: span)
    }*/
    
    func addAnnotation(_ title: String, _ coordinate: (Double, Double)) {
        let realm = try! Realm()
        let annotation = AnnotationObj()
        /*
        if realm.objects(AnnotationObj.self).count == 0 {
            annotation.annotationID = 0
        } else {
            let lastAnnotation = realm.objects(AnnotationObj.self).sorted(byKeyPath: "AnnotationID").last
            annotation.annotationID = lastAnnotation.annotationID + 1
        }*/
        if realm.objects(AnnotationObj.self).filter("title == %@", title).count == 0 {
            if let lastAnnotation = realm.objects(AnnotationObj.self).sorted(byKeyPath: "annotationID").last {
                annotation.annotationID = lastAnnotation.annotationID + 1
            } else {
                annotation.annotationID = 0
            }
            annotation.title = title
            annotation.longitude = coordinate.0
            annotation.latitude = coordinate.1
            try! realm.write {
                realm.add(annotation)
            }
            delegate?.addAnnotation(annotation: annotation)
        }
        self.regionCenter = coordinate
        //self.annotations = realm.objects(AnnotationObj.self)
    }
}
