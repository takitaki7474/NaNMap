//
//  ClassLocationViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/30.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

protocol ClassLocationPresenter {
    
}

class ClassLocationViewPresenter: ClassLocationPresenter {
    private let timeTablePresenter: TimeTablePresenter!
    private let cellIndex: Int!
    
    init(presenter: TimeTablePresenter, index: Int) {
        self.timeTablePresenter = presenter
        self.cellIndex = index
        loadSyllabus()
    }
    
    private func loadSyllabus() {
        //print(timeTablePresenter.loadSavedSyllabus(at: self.cellIndex))
    }
}
