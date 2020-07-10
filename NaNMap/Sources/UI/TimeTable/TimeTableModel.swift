//
//  TimeTableModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/19.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol TimeTableModelDelegate: class {
    func alertWillSearchSyllabus(with text: String)
}

class TimeTableModel {
    weak var delegate: TimeTableModelDelegate?
    
    func setAlertText(at index: Int) {
        let week: [String] = ["月", "火", "水", "木", "金", "土"]
        let period: [String] = ["1", "2", "3", "4", "5"]
        let text = week[(index % 7) - 1] + period[(index / 7) - 1]
        delegate?.alertWillSearchSyllabus(with: text)
    }
}
