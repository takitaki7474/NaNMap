//
//  Syllabus.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

struct Subject: Codable {
    var category: String
    var semester: String
    var subjectName: String
    var teacher: String
    var degree: String
    var schedule: String
    var classroom: String
    var id: Int
}
