//
//  SyllabusSearchModel.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import Foundation
import RealmSwift

class SubjectObj: Object {
    @objc dynamic var category = ""
    @objc dynamic var semester = ""
    @objc dynamic var subjectName = ""
    @objc dynamic var teacher = ""
    @objc dynamic var degree = ""
    @objc dynamic var schedule = ""
    @objc dynamic var classroom = ""
    @objc dynamic var id = 0
}

protocol SyllabusSearchModelDelegate: class {
    func searchModel()
}

class SyllabusSearchModel {
    private var data: Data?
    weak var delegate: SyllabusSearchModelDelegate?
    var syllabus: [Subject]?
    var classSchedule: String?
    var syllabusSearchResult: Results<SubjectObj>? {
        didSet {
            delegate?.searchModel()
        }
    }
    
    init() {
        let path = Bundle.main.path(forResource: "Syllabus", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)
    }
    
    func loadSyllabus() {
        let decoder = JSONDecoder()
        guard let syllabus = try? decoder.decode([Subject].self, from: self.data!) else {
            print("syllabus decode error")
            return
        }
        self.syllabus = syllabus
        saveSyllabus()
    }
    
    private func saveSyllabus() {
        let realm: Realm
        do {
            realm = try Realm()
        } catch {
            removeRealmFile()
            realm = try! Realm()
        }

        try! realm.write {
            realm.deleteAll()
            for subject in self.syllabus! {
                let subjectObj = SubjectObj()
                subjectObj.category = subject.category
                subjectObj.semester = subject.semester
                subjectObj.subjectName = subject.subjectName
                subjectObj.teacher = subject.teacher
                subjectObj.degree = subject.degree
                subjectObj.schedule = subject.schedule
                subjectObj.classroom = subject.classroom
                subjectObj.id = subject.id
                realm.add(subjectObj)
            }
        }
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
}

extension SyllabusSearchModel {
    func loadTappedScheduleSyllabus(by classSchedule: String) {
        self.classSchedule = classSchedule
        let realm = try! Realm()
        let result = realm.objects(SubjectObj.self).filter("schedule == %@", self.classSchedule!).sorted(byKeyPath: "semester")
        self.syllabusSearchResult = result
    }
    
    func searchSyllabus(with query: String) {
        let realm = try! Realm()
        var result = realm.objects(SubjectObj.self).filter("schedule == %@", self.classSchedule!).sorted(byKeyPath: "semester")
        result = result.filter("semester CONTAINS %@ OR subjectName CONTAINS %@ OR teacher CONTAINS %@ OR classroom CONTAINS %@", query, query, query, query)
        self.syllabusSearchResult = result
    }
}
