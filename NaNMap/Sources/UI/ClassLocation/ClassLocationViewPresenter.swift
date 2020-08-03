//
//  ClassLocationViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/30.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

protocol ClassLocationPresenter {
    var view: ClassLocationView? { get set }
    func loadClassLocation()
}

class ClassLocationViewPresenter: ClassLocationPresenter {
    weak var view: ClassLocationView?
    private let timeTablePresenter: TimeTablePresenter!
    private let cellIndex: Int!
    
    init(presenter: TimeTablePresenter, index: Int) {
        self.timeTablePresenter = presenter
        self.cellIndex = index
    }
    
    func loadClassLocation() {
        let syllabus = timeTablePresenter.loadSavedSyllabus(at: self.cellIndex)
        let title = syllabus.subjectName
        var coordinate: (Double, Double)? = nil
        if let classroomObj = syllabus.classroom, let buildingObj = classroomObj.building {
            coordinate = (buildingObj.latitude, buildingObj.longitude)
        }
        view?.loadMap(title: title, coordinate: coordinate)
    }
}
