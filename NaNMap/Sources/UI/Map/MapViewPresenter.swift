//
//  MapViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/15.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import MapKit

protocol MapPresenter {
    //func setUpMapRegion()
    //func setPin(with info: [Building], at index: Int)
    func addAnnotation(with info: [Building], at index: Int)
}

final class MapViewPresenter: MapPresenter {
    weak var view: MapView?
    private let model = MapModel()
    
    init(view: MapView) {
        self.view = view
        model.delegate = self
        model.loadAnnotations()
    }
    /*
    func setUpMapRegion() {
        model.setUpMapRegion()
    }*/
    /*
    func setPin(with info: [Building], at index: Int) {
        let title: String = info[index].building
        let longitude: Double = info[index].coordinate.longitude
        let latitude: Double = info[index].coordinate.latitude
        model.setPin(title, (longitude, latitude))
    }*/
    
    func addAnnotation(with info: [Building], at index: Int) {
        let title: String = info[index].building
        let longitude: Double = info[index].coordinate.longitude
        let latitude: Double = info[index].coordinate.latitude
        model.addAnnotation(title, (longitude, latitude))
    }
}

extension MapViewPresenter: MapModelDelegate {
    /*func reloadMap(annotations: AnnotationObj) {
        
    }*/
    func loadAnnotations(annotations: [AnnotationObj]) {
        view?.loadAnnotations(annotations: annotations)
    }
    
    func addAnnotation(annotation: AnnotationObj) {
        view?.addAnnotation(annotation: annotation)
    }
    
    func reloadMapRegion(at center: (Double, Double)) {
        view?.reloadMapRegion(at: center)
    }
    func reloadRegion(at region: MKCoordinateRegion) {
        view?.reloadRegion(at: region)
    }
    
    func addPin(with pin: MKPointAnnotation) {
        view?.addPin(with: pin)
    }
}
