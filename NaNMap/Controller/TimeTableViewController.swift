//
//  TimeTableViewController.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/22.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var customCellCreator: CustomCellCreator!
    
    static func instantinate() -> TimeTableViewController {
         return UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "timeTableViewController") as! TimeTableViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customCellCreator = CustomCellCreator()
        setUpCollectionView()
        setUpNavigationBar()
    }
}


private extension TimeTableViewController {
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.rgba(red: 85,green: 104,blue: 211)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "時間割"
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        customCellCreator.customizeCellLayout()
        collectionView.collectionViewLayout = customCellCreator.cellLayout!
        collectionView.layer.borderColor = UIColor.white.cgColor
        collectionView.layer.borderWidth = 2
    }
}


private extension TimeTableViewController {
    
    func alertChangeTimeTable(indexPath: IndexPath) {
        let dayOfWeek: [String] = ["月", "火", "水", "木", "金", "土"]
        let period: [String] = ["1", "2", "3", "4", "5"]
        let clickedCellText = dayOfWeek[(indexPath.row % 7) - 1] + period[(indexPath.row / 7) - 1]
        let alert = UIAlertController(title: "時間割の編集", message: clickedCellText + "の講義を編集しますか?", preferredStyle: UIAlertController.Style.actionSheet)
        let defaultAction = UIAlertAction(title: clickedCellText + "の講義を検索する", style: UIAlertAction.Style.default, handler: {
            (action:UIAlertAction) -> Void in
        })
        let cancelAction = UIAlertAction(title: "戻る", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction) -> Void in
        })
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


extension TimeTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableCell", for: indexPath)
        cell.backgroundColor = UIColor.rgba(red: 186, green: 193, blue: 234)
        cell.layer.cornerRadius = 4
        customCellCreator.customizeCellLabelFlowLayout(indexPath: indexPath, cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(indexPath.row <= 6 || indexPath.row % 7 == 0) {
            alertChangeTimeTable(indexPath: indexPath)
        }
    }
}


extension TimeTableViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        customCellCreator.customizeCellSizeFlowLayout(indexPath: indexPath, collectionView: collectionView)
        return customCellCreator.cellSize!
    }
}
