//
//  SearchViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/09.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var searchBar: UISearchBar!
    
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
        setUpSearchBar()
    }
    
    func setUpSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.placeholder = "場所や目的地を検索"
            searchBar.searchTextField.backgroundColor = UIColor.white
            searchBar.tintColor = UIColor.gray
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            self.searchBar = searchBar
        }
    }
}
