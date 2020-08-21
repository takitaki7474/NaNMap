//
//  SyllabusSearchViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
protocol SyllabusSearchPresenter {
    var view: SyllabusSearchView? { get set }
    var numberOfSyllabusSearchResult: Int { get }
    var numberOfFilterList: Int { get }
    func loadTappedScheduleSyllabus(by classSchedule: String)
    func loadSyllabusSearchResult(at index: Int) -> SubjectObj?
    func searchSyllabus(with query: String)
    func loadFilter(at index: Int) -> Filter?
    func filterSyllabus(at index: Int)
    func setAlertWillAddTimeTable(with scheduleText: String, at index: Int)
    func loadSelectedSyllabus(at index: Int, classScheduleIndex: Int)
}

final class SyllabusSearchViewPresenter: SyllabusSearchPresenter {
    private let model = SyllabusSearchModel()
    private let timeTablePresenter: TimeTablePresenter!
    weak var view: SyllabusSearchView?
    
    init(preseter: TimeTablePresenter) {
        self.timeTablePresenter = preseter
        self.model.delegate = self
    }
    
    var numberOfSyllabusSearchResult: Int {
        if let count = model.syllabusSearchResult?.count {
            return count
        } else {
            return 0
        }
    }
    
    var numberOfFilterList: Int {
        if let count = model.filterList?.count {
            return count
        } else {
            return 0
        }
    }
    
    func loadTappedScheduleSyllabus(by classSchedule: String) {
        model.loadTappedScheduleSyllabus(by: classSchedule)
    }
    
    func loadSyllabusSearchResult(at index: Int) -> SubjectObj? {
        return model.syllabusSearchResult?[index]
    }
    
    func searchSyllabus(with query: String) {
        model.searchSyllabus(with: query)
    }
    
    func loadFilter(at index: Int) -> Filter? {
        return model.filterList?[index]
    }
    
    func filterSyllabus(at index: Int) {
        model.filterSyllabus(at: index)
    }
    
    func setAlertWillAddTimeTable(with scheduleText: String, at index: Int) {
        view?.alertWillAddTimeTable(with: scheduleText, at: index)
    }
    
    func loadSelectedSyllabus(at index: Int, classScheduleIndex: Int) {
        let selectedSyllabus = model.syllabusSearchResult?[index]
        timeTablePresenter.saveSelectedSyllabus(syllabus: selectedSyllabus, classScheduleIndex: classScheduleIndex)
    }
}

extension SyllabusSearchViewPresenter: SyllabusSearchModelDelegate {
    func searchModel() {
        view?.reloadData()
    }
}
