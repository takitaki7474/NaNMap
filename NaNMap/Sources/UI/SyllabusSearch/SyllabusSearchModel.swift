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

class ClassroomObj: Object {
    @objc dynamic var classroom = ""
    @objc dynamic var building: BuildingObj?
    override static func primaryKey() -> String? {
        return "classroom"
    }
}

class BuildingObj: Object {
    @objc dynamic var building = ""
    @objc dynamic var longitude = 0.0
    @objc dynamic var latitude = 0.0
    let facilities = List<String>()
    override static func primaryKey() -> String? {
        return "building"
    }
}

protocol SyllabusSearchModelDelegate: class {
    func searchModel()
}

class SyllabusSearchModel {
    weak var delegate: SyllabusSearchModelDelegate?
    var filterList: [FilterEntity]?
    var syllabus: [Subject]?
    var classSchedule: String?
    var syllabusSearchResult: Results<SubjectObj>? {
        didSet {
            delegate?.searchModel()
        }
    }
    
    init() {
        loadBuildingsData()
        loadSyllabus()
        loadFilter()
    }
    
    private func loadBuildingsData() {
        let path = Bundle.main.path(forResource: "Buildings", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        guard let buildings = try? decoder.decode([Building].self, from: data!) else {
            return
        }
        saveClassroomObj(buildings: buildings)
    }
    
    private func saveClassroomObj(buildings: [Building]) {
        let realm = try! Realm()
        if realm.objects(ClassroomObj.self).count == 0 && realm.objects(BuildingObj.self).count == 0 {
            for building in buildings {
                let buildingObj = BuildingObj()
                buildingObj.building = building.building
                buildingObj.longitude = building.coordinate.longitude
                buildingObj.latitude = building.coordinate.latitude
                if let facilities = building.facilities {
                    for facility in facilities {
                        buildingObj.facilities.append(facility.facilityName)
                    }
                }
                if let classrooms = building.classrooms {
                    for classroom in classrooms {
                        let classroomObj = ClassroomObj()
                        classroomObj.classroom = classroom.classroomName
                        classroomObj.building = buildingObj
                        try! realm.write {
                            realm.add(classroomObj)
                        }
                    }
                }
            }
        }
        print("test")
        print(realm.objects(ClassroomObj.self))
    }
    
    private func loadSyllabus() {
        let path = Bundle.main.path(forResource: "Syllabus", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        guard let syllabus = try? decoder.decode([Subject].self, from: data!) else {
            print("syllabus decode error")
            return
        }
        self.syllabus = syllabus
        
        let realm = try! Realm()
        if realm.objects(SubjectObj.self).count == 0 { initSyllabus(realm: realm) }
    }
    
    private func initSyllabus(realm: Realm) {
        try! realm.write {
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
        print("save SubjectObj on realm")
    }
    
    private func loadFilter() {
        let path = Bundle.main.path(forResource: "Filter", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        guard let filter = try? decoder.decode([FilterEntity].self, from: data!) else {
            print("filter decode error")
            return
        }
        self.filterList = filter
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
    
    func filterSyllabus(at index: Int) {
        let filters: [String]? = self.filterList?[index].filterSyllabusWords
        let realm = try! Realm()
        var result = realm.objects(SubjectObj.self).filter("schedule == %@", self.classSchedule!).sorted(byKeyPath: "semester")
        if filters != [] { // with filter
            let categoryPredicate = NSPredicate(format: "category IN %@", argumentArray: [filters as Any])
            let semesterPerdicate = NSPredicate(format: "semester IN %@", argumentArray: [filters as Any])
            let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [categoryPredicate, semesterPerdicate])
            result = result.filter(predicate)
        }
        self.syllabusSearchResult = result
    }
}
