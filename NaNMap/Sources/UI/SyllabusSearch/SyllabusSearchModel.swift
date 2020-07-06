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
            print("syllabus decode error")
            return
        }
        self.syllabus = syllabus
        saveSyllabus()
        testSearch()
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
        let realm = try! Realm()
        let result = realm.objects(SubjectObj.self).filter("id < 5")
        //let result = realm.objects(SubjectObj.self).filter("schedule == %@", "火4")
        print(result)
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
                print("realm clear")
            } catch {
                print("realm clear error")
            }
        }
    }
}
