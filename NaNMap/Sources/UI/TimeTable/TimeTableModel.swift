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
    @objc dynamic var classroom: ClassroomObj?
    @objc dynamic var hasRegistered = false
}

protocol TimeTableModelDelegate: class {
    func notifyLoadingTimeTable()
}

final class TimeTableModel {
    weak var delegate: TimeTableModelDelegate?
    var timeTableCells: Results<TimeTableCellObj>? {
        didSet {
            delegate?.notifyLoadingTimeTable()
        }
    }
    
    init() {
        loadTimeTableCell()
    }
    
    private func loadTimeTableCell() {
        let realm = try! Realm()
        if realm.objects(TimeTableCellObj.self).count == 0 { initTimeTableCell(realm: realm) }
        self.timeTableCells = realm.objects(TimeTableCellObj.self)
    }
    
    private func initTimeTableCell(realm: Realm) {
        try! realm.write {
            for _ in 0...41 {
                let timeTableCellObj = TimeTableCellObj()
                realm.add(timeTableCellObj)
            }
        }
        print("save TimeTableCellObj on realm")
    }
    
    private func removeRealmFile() {
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
                print("remove realm file")
            } catch {
                print("remove realm file error")
            }
        }
    }
    
    func saveSelectedSyllabus(syllabus: SubjectObj, index: Int) {
        let realm = try! Realm()
        let timeTableCell = realm.objects(TimeTableCellObj.self)[index]
        try! realm.write {
            timeTableCell.category = syllabus.category
            timeTableCell.semester = syllabus.semester
            timeTableCell.subjectName = syllabus.subjectName
            timeTableCell.teacher = syllabus.teacher
            timeTableCell.classroom = syllabus.classroom
            timeTableCell.hasRegistered = true
        }
        self.timeTableCells = realm.objects(TimeTableCellObj.self)
    }
    
    func unregisterSyllabus(at index: Int) {
        let realm = try! Realm()
        let timeTableCell = realm.objects(TimeTableCellObj.self)[index]
        try! realm.write {
            timeTableCell.category = ""
            timeTableCell.semester = ""
            timeTableCell.subjectName = ""
            timeTableCell.teacher = ""
            timeTableCell.classroom = nil
            timeTableCell.hasRegistered = false
        }
        self.timeTableCells = realm.objects(TimeTableCellObj.self)
    }
}
