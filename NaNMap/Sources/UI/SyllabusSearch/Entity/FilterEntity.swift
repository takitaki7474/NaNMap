//
//  FilteringEntity.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/08.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

struct FilterEntity: Codable {
    var id: Int
    var parentCategory: String
    var childCategory: [String]
}
