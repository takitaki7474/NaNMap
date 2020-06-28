//
//  SyllabusSearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/06/28.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class SyllabusSearchViewController: UIViewController {
    private var timeTablePresenter: TimeTablePresenter!
    private var syllabusSearchPresenter: SyllabusSearchPresenter!
    
    static func instantinate(syllabusSearchPresenter: SyllabusSearchPresenter) -> SyllabusSearchViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "syllabusSearchViewController") as! SyllabusSearchViewController
        controller.syllabusSearchPresenter = syllabusSearchPresenter
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
