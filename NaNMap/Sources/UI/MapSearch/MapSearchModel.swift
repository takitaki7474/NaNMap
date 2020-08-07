//
//  SearchModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/16.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation
import RealmSwift

class MapBuildingObj: Object {
    @objc dynamic var building = ""
    @objc dynamic var longitude = 0.0
    @objc dynamic var latitude = 0.0
    let facilities = List<MapFacilityObj>()
    override static func primaryKey() -> String? {
        return "building"
    }
}

class MapFacilityObj: Object {
    @objc dynamic var facilityName = ""
    @objc dynamic var floor = ""
}

protocol MapSearchModelDelegate: class {
    func searchModel()
}

final class MapSearchModel {
    weak var delegate: MapSearchModelDelegate?
    var buildings: [Building]?
    var buildingSearchResults: Results<MapBuildingObj>? {
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
        saveMapBuildingObj(buildings: buildings)
    }
    
    private func saveMapBuildingObj(buildings: [Building]) {
        let realm = try! Realm()
        if realm.objects(MapBuildingObj.self).count == 0 {
            try! realm.write {
                for building in buildings {
                    let mapBuildingObj = MapBuildingObj()
                    mapBuildingObj.building = building.building
                    mapBuildingObj.longitude = building.coordinate.longitude
                    mapBuildingObj.latitude = building.coordinate.latitude
                    if let facilities = building.facilities {
                        for facility in facilities {
                            let mapFacilityObj = MapFacilityObj()
                            mapFacilityObj.facilityName = facility.facilityName
                            mapFacilityObj.floor = facility.floor
                            mapBuildingObj.facilities.append(mapFacilityObj)
                        }
                    }
                    realm.add(mapBuildingObj)
                }
            }
            print("save MapBuildingObj on realm")
        }
    }
}

extension MapSearchModel {
    func searchBuilding(with query: String) {
        let realm = try! Realm()
        var result = realm.objects(MapBuildingObj.self)
        let buildingPredicate = NSPredicate(format: "building CONTAINS %@", argumentArray: [query])
        let facilityNamePredicate = NSPredicate(format: "SUBQUERY(facilities, $facility, $facility.facilityName CONTAINS %@).@count >= 1", argumentArray: [query])
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [buildingPredicate, facilityNamePredicate])
        result = result.filter(predicate)
        self.buildingSearchResults = result
    }
}
