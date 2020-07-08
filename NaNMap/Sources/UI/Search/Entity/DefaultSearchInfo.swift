//
//  defaultSearchCandidates.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/20.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

struct DefaultSearchInfo: Codable {
    var section: [Section]
}

struct Section: Codable {
    var row: [Row]
}

struct Row: Codable {
    var title: String
    var nextPage: [BuildingInfo]
}

struct BuildingInfo: Codable {
    var building: String
    var coordinate: Coordinate
    var facility: [FacilityInfo]?
}

struct Coordinate: Codable {
    var longitude: Double
    var latitude: Double
}

struct FacilityInfo: Codable {
    var facilityName: String
    var floor: String
}
