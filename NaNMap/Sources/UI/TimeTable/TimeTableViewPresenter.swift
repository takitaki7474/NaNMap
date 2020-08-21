//
//  TimeTableViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/19.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import Foundation

protocol TimeTablePresenter {
    func setAlertWillSearchSyllabus(at index: Int)
    func setAlertWillDeleteSyllabus(at index: Int)
    func saveSelectedSyllabus(syllabus: SubjectObj?, classScheduleIndex: Int)
    func loadSavedSyllabus(at index: Int) -> TimeTableCellObj
    func unregisterSyllabus(at index: Int)
}

final class TimeTableViewPresenter: TimeTablePresenter {
    weak var view: TimeTableView?
    private let model = TimeTableModel()
    
    init(view: TimeTableView) {
        self.view = view
        model.delegate = self
    }
    
    func setAlertWillSearchSyllabus(at index: Int) {
        let canClickCell = !(index <= 6 || index % 7 == 0)
        if canClickCell {
            let week: [String] = ["月", "火", "水", "木", "金", "土"]
            let period: [String] = ["1", "2", "3", "4", "5"]
            let text = week[(index % 7) - 1] + period[(index / 7) - 1]
            view?.alertWillSearchSyllabus(with: text, at: index)
        }
    }
    
    func setAlertWillDeleteSyllabus(at index: Int) {
        let cellLables = model.timeTableCells![index]
        if cellLables.hasRegistered == true {
            let week: [String] = ["月", "火", "水", "木", "金", "土"]
            let period: [String] = ["1", "2", "3", "4", "5"]
            let text = week[(index % 7) - 1] + period[(index / 7) - 1]
            view?.alertWillDeleteSyllabus(with: text, at: index)
        }
    }
    
    func saveSelectedSyllabus(syllabus: SubjectObj?, classScheduleIndex: Int) {
        model.saveSelectedSyllabus(syllabus: syllabus!, index: classScheduleIndex)
    }
    
    func loadSavedSyllabus(at index: Int) -> TimeTableCellObj {
        return model.timeTableCells![index]
    }
    
    func unregisterSyllabus(at index: Int) {
        model.unregisterSyllabus(at: index)
    }
}

extension TimeTableViewPresenter: TimeTableModelDelegate {
    func notifyLoadingTimeTable() {
        view?.reloadData()
    }
}
