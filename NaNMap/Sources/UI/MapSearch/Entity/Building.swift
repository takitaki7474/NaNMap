//
//  Buildings.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/27.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

struct Building: Codable {
    var building: String
    var coordinate: Coordinate
    var facilities: [Facility]?
    var classrooms: [Classroom]?
}

struct Coordinate: Codable {
    var longitude: Double
    var latitude: Double
}

struct Facility: Codable {
    var facilityName: String
    var floor: String
}

struct Classroom: Codable {
    var classroomName: String
    var floor: String
}
