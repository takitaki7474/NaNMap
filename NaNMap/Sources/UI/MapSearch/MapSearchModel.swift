//
//  SearchModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/16.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation
import RealmSwift

class MapSearchLocationObj: Object {
    @objc dynamic var locationName = ""
    @objc dynamic var subInfo = ""
    @objc dynamic var floor = ""
    @objc dynamic var longitude = 0.0
    @objc dynamic var latitude = 0.0
}

protocol MapSearchModelDelegate: class {
    func searchModel()
}

final class MapSearchModel {
    weak var delegate: MapSearchModelDelegate?
    var buildings: [Building]?
    var defaultSearchJSONNames: [String] = ["ClassroomBuildings", "Cafeterias", "ConvenienceStores", "BookStores"]
    var defaultSearchResults: [Location]?
    var locationSearchResults: Results<MapSearchLocationObj>? {
        didSet {
            delegate?.searchModel()
        }
    }
    
    init() {
        loadBuildingsData()
    }
    
    private func loadBuildingsData() {
        let path = Bundle.main.path(forResource: "Buildings", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        guard let buildings = try? decoder.decode([Building].self, from: data!) else {
            return
        }
        self.buildings = buildings
        saveMapSearchLocationObj(buildings: buildings)
    }
    
    private func saveMapSearchLocationObj(buildings: [Building]) {
        let realm = try! Realm()
        if realm.objects(MapSearchLocationObj.self).count == 0 {
            try! realm.write {
                for building in buildings {
                    let mapSearchLocationObj = MapSearchLocationObj()
                    mapSearchLocationObj.locationName = building.building
                    mapSearchLocationObj.longitude = building.coordinate.longitude
                    mapSearchLocationObj.latitude = building.coordinate.latitude
                    realm.add(mapSearchLocationObj)
                    if let facilities = building.facilities {
                        for facility in facilities {
                            let mapSearchLocationObj = MapSearchLocationObj()
                            mapSearchLocationObj.locationName = facility.facilityName
                            mapSearchLocationObj.subInfo = building.building
                            mapSearchLocationObj.floor = facility.floor
                            mapSearchLocationObj.longitude = building.coordinate.longitude
                            mapSearchLocationObj.latitude = building.coordinate.latitude
                            realm.add(mapSearchLocationObj)
                        }
                    }
                    if let classrooms = building.classrooms {
                        for classroom in classrooms {
                            let mapSearchLocationObj = MapSearchLocationObj()
                            mapSearchLocationObj.locationName = classroom.classroomName
                            mapSearchLocationObj.subInfo = building.building
                            mapSearchLocationObj.floor = classroom.floor
                            mapSearchLocationObj.longitude = building.coordinate.longitude
                            mapSearchLocationObj.latitude = building.coordinate.latitude
                            realm.add(mapSearchLocationObj)
                        }
                    }
                }
                print("save MapFacilityObj on realm")
            }
        }
    }
    
    func loadDefaultSearchResults(defaultIndex: Int) {
        let path = Bundle.main.path(forResource: defaultSearchJSONNames[defaultIndex], ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        guard let locations = try? decoder.decode([Location].self, from: data!) else {
            return
        }
        self.defaultSearchResults = locations
    }
}

extension MapSearchModel {
    func searchLocation(with query: String) {
        let realm = try! Realm()
        var result = realm.objects(MapSearchLocationObj.self)
        let locationNamePredicate = NSPredicate(format: "locationName CONTAINS %@", argumentArray: [query])
        let subInfoPredicate = NSPredicate(format: "subInfo CONTAINS %@", argumentArray: [query])
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [locationNamePredicate, subInfoPredicate])
        result = result.filter(predicate)
        self.locationSearchResults = result
    }
}
