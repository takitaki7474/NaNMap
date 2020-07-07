//
//  FilterPopUpViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/08.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class FilterPopUpViewController: UIViewController {
    private var syllabusSearchPresenter: SyllabusSearchPresenter!
    
    static func instantinate(syllabusSearchPresenter: SyllabusSearchPresenter) -> FilterPopUpViewController {
        let controller = UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "filterPopUpViewController") as! FilterPopUpViewController
        controller.syllabusSearchPresenter = syllabusSearchPresenter
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
