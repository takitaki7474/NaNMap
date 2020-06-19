//
//  TimeTableViewPresenter.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/19.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

protocol TimeTablePresenter {
    func setAlertText(at index: Int)
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
}

extension TimeTableViewPresenter: TimeTableModelDelegate {
    func alertChangingTimeTable(with text: String) {
        view?.alertChangingTimeTable(with: text)
    }
}
