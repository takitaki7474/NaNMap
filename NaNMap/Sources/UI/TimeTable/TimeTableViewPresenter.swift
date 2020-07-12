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
    func loadSavedSyllabus(at index: Int) -> TimeTableCellObj
}

class TimeTableViewPresenter: TimeTablePresenter {
    weak var view: TimeTableView?
    private let model = TimeTableModel()
    
    init(view: TimeTableView) {
        self.view = view
        model.delegate = self
    }
    
    func setTimeTableCellLabel(at index: Int) {
        
    }
    
    func setAlertText(at index: Int) {
        let canClickCell = !(index <= 6 || index % 7 == 0)
        if canClickCell {
            model.setAlertText(at: index)
        }
    }
    
    func saveSelectedSyllabus(syllabus: SubjectObj?) {
        
    }
    
    func loadSavedSyllabus(at index: Int) -> TimeTableCellObj {
        return model.timeTableCell![index]
    }
    
    
}

extension TimeTableViewPresenter: TimeTableModelDelegate {
    func alertWillSearchSyllabus(with text: String) {
        view?.alertWillSearchSyllabus(with: text)
    }
    func notifyLoadingTimeTable() {
        print("bb")
        view?.reloadData()
    }
}
