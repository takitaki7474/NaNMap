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
    
    static func instantinate() -> TimeTableViewController {
         return UIStoryboard(name: "TimeTable", bundle: nil).instantiateViewController(withIdentifier: "timeTableViewController") as! TimeTableViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
}


private extension TimeTableViewController {
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        collectionView.collectionViewLayout = layout
    }
}


extension TimeTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}


extension TimeTableViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.frame.width
        let viewHeight = collectionView.frame.height
        let firstCellOneSideSize: CGFloat = 30.0
        let scheduleCellWidth = (viewWidth - firstCellOneSideSize - 2*6) / 6.0
        let scheduleCellHeight = (viewHeight - firstCellOneSideSize - 2*5) / 5.0
        var width: CGFloat?
        var height: CGFloat?
        
        switch indexPath.row {
        case 0:
            width = firstCellOneSideSize
            height = firstCellOneSideSize
        case 1...6:
            width = scheduleCellWidth
            height = firstCellOneSideSize
        case let index where index % 7 == 0:
            width = firstCellOneSideSize
            height = scheduleCellHeight
        default:
            width = scheduleCellWidth
            height = scheduleCellHeight
        }
        
        return CGSize(width: width!, height: height!)
    }
}
