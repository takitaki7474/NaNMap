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
    }
}


private extension TimeTableViewController {
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        customCellCreator.customizeCellLayout()
        collectionView.collectionViewLayout = customCellCreator.cellLayout!
    }
}


extension TimeTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableCell", for: indexPath)
        cell.backgroundColor = .gray
        let label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = "1"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.center.x = cell.frame.width/2.0
        label.center.y = cell.frame.height/2.0
        return cell
    }
}


extension TimeTableViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        customCellCreator.customizeCellSize(indexPath: indexPath, collectionView: collectionView)
        return customCellCreator.cellSize!
    }
}
