//
//  TimeTableViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/19.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol TimeTablePresenter {
    func setAlertText(at index: Int)
    func saveSelectedSyllabus(syllabus: SubjectObj?)
}

class TimeTableViewPresenter: TimeTablePresenter {
    weak var view: TimeTableView?
    private let model = TimeTableModel()
    
    init(view: TimeTableView) {
        self.view = view
        model.delegate = self
    }
    
    func setAlertText(at index: Int) {
        model.setAlertText(at: index)
    }
    
    func saveSelectedSyllabus(syllabus: SubjectObj?) {
        
    }
}

extension TimeTableViewPresenter: TimeTableModelDelegate {
    func alertWillSearchSyllabus(with text: String) {
        view?.alertWillSearchSyllabus(with: text)
    }
}
