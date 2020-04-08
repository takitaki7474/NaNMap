//
//  SearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/09.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    static func instantinate() -> SearchViewController {
        return UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as! SearchViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
}

private extension SearchViewController {
    
    func setUpNavigationBar() {
        navigationItem.hidesBackButton = true
    }
}
