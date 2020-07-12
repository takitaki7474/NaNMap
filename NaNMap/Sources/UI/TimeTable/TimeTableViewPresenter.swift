//
//  TimeTableViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/19.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol TimeTablePresenter {
    func setAlertWillSearchSyllabus(at index: Int)
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
    
    func setAlertWillSearchSyllabus(at index: Int) {
        let week: [String] = ["月", "火", "水", "木", "金", "土"]
        let period: [String] = ["1", "2", "3", "4", "5"]
        let text = week[(index % 7) - 1] + period[(index / 7) - 1]
        let canClickCell = !(index <= 6 || index % 7 == 0)
        if canClickCell {
            view?.alertWillSearchSyllabus(with: text)
        }
    }
    
    func saveSelectedSyllabus(syllabus: SubjectObj?) {
        
    }
    
    func loadSavedSyllabus(at index: Int) -> TimeTableCellObj {
        return model.timeTableCell![index]
    }
    
    
}

extension TimeTableViewPresenter: TimeTableModelDelegate {
    func notifyLoadingTimeTable() {
        view?.reloadData()
    }
}
