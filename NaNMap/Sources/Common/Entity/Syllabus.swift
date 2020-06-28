//
//  Syllabus.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

struct Syllabus: Codable {
    var undergraduate: [Subject]
    var graduate: [Subject]
}

struct Subject: Codable {
    var category: String
    var semester: String
    var subject_name: String
    var class_schedule: [String]
    var classroom: [String]
    var teacher: String
}
