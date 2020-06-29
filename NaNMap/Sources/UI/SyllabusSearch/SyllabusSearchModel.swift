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
    dynamic var category = ""
    dynamic var semester = ""
    dynamic var subjectName = ""
    dynamic var teather = ""
    dynamic var degree = ""
    dynamic var schedule = ""
    dynamic var classroom = ""
    dynamic var id = 0
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
        print(syllabus.count)
    }
    /*
    private func saveSubject(_ degree: String) {
        var subjects: [Subject]?
        switch degree {
        case "undergraduate":
            subjects = self.syllabus?.undergraduate
        case "graduate":
            subjects = self.syllabus?.graduate
        default:
            print("error: subjects is nil")
        }
        let subjectObj = SubjectObj()
        let realm = try! Realm()
        for subject in subjects! {
            subjectObj.category = subject.category
            subjectObj.semester = subject.semester
            subjectObj.subjectName = subject.subjectName
            
        }
        
    }*/
}
