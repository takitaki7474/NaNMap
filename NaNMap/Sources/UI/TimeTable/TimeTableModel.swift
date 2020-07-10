//
//  TimeTableModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/19.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import RealmSwift

class TimeTableCellObj: Object {
    @objc dynamic var category = ""
    @objc dynamic var semester = ""
    @objc dynamic var subjectName = ""
    @objc dynamic var teacher = ""
    @objc dynamic var classroom = ""
}

protocol TimeTableModelDelegate: class {
    func alertWillSearchSyllabus(with text: String)
}

class TimeTableModel {
    weak var delegate: TimeTableModelDelegate?
    var timeTableCell: Results<TimeTableCellObj>? {
        didSet {
            
        }
    }
    
    init() {
        loadTimeTableCell()
    }
    
    private func loadTimeTableCell() {
        let realm = try! Realm()
        if realm.objects(TimeTableCellObj.self).count == 0 { saveTimeTableCell(realm: realm) }
        self.timeTableCell = realm.objects(TimeTableCellObj.self)
    }
    
    private func saveTimeTableCell(realm: Realm) {
        try! realm.write {
            for _ in 0...42 {
                let timeTableCellObj = TimeTableCellObj()
                realm.add(timeTableCellObj)
            }
        }
        print("save TimeTableCellObj on realm")
    }
    
    func setAlertText(at index: Int) {
        let week: [String] = ["月", "火", "水", "木", "金", "土"]
        let period: [String] = ["1", "2", "3", "4", "5"]
        let text = week[(index % 7) - 1] + period[(index / 7) - 1]
        delegate?.alertWillSearchSyllabus(with: text)
    }
}
