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
    @objc dynamic var teather = ""
    @objc dynamic var degree = ""
    @objc dynamic var schedule = ""
    @objc dynamic var classroom = ""
    @objc dynamic var id = 0
}

class SyllabusSearchModel {
    private var data: Data?
    var syllabus: [Subject]?
    
    init() {
        let path = Bundle.main.path(forResource: "Syllabus", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        self.data = try? Data(contentsOf: url)
    }
    
    func loadSyllabus() {
        let decoder = JSONDecoder()
        guard let syllabus = try? decoder.decode([Subject].self, from: self.data!) else {
            print("error")
            return
        }
        self.syllabus = syllabus
        saveSyllabus()
        testSearch()
    }
    
    private func saveSyllabus() {
        let config = Realm.Configuration(inMemoryIdentifier: "inMemory")
        let realm = try! Realm(configuration: config)
        try! realm.write {
            for subject in self.syllabus! {
                let subjectObj = SubjectObj()
                subjectObj.category = subject.category
                subjectObj.semester = subject.semester
                subjectObj.subjectName = subject.subjectName
                subjectObj.teather = subject.teacher
                subjectObj.degree = subject.degree
                subjectObj.schedule = subject.schedule
                subjectObj.classroom = subject.classroom
                subjectObj.id = subject.id
                realm.add(subjectObj)
            }
        }
    }
    
    private func testSearch() {
        let config = Realm.Configuration(inMemoryIdentifier: "inMemory")
        let realm = try! Realm(configuration: config)
        let result = realm.objects(SubjectObj.self).filter("id < 5")
        print(result)
    }
}
