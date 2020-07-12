//
//  CustomCellFlowLayout.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/23.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//
import UIKit

class TimeTableCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var classroomLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    var presenter: TimeTablePresenter!
    
    func customizeCellStyle() {
        self.backgroundColor = UIColor.rgba(red: 186, green: 193, blue: 234)
        self.layer.cornerRadius = 4
    }
    
    func customizeCellLabelStyle(index: Int) {
        switch index {
        case 0...6, 7, 14, 21, 28, 35:
            let fontSize: CGFloat = 16.0
            subjectNameLabel.font = UIFont.systemFont(ofSize: fontSize)
            subjectNameLabel.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        default :
            let maxSize = CGSize(width: self.frame.width * 0.9, height: CGFloat.greatestFiniteMagnitude)
            subjectNameLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: subjectNameLabel.sizeThatFits(maxSize))
            classroomLabel.frame.size = CGSize(width: self.frame.width*0.9, height: 16)
            teacherLabel.frame.size = CGSize(width: self.frame.width*0.9, height: 16)
            subjectNameLabel.center = CGPoint(x: self.frame.width/2, y: self.frame.height/4)
            classroomLabel.center = CGPoint(x: self.frame.width/2, y: self.frame.height*2/3)
            teacherLabel.center = CGPoint(x: self.frame.width/2, y: self.frame.height*5/6)
        }
    }
    
    func customizeCellLabelText(index: Int) {
        let week: [String] = ["月", "火", "水", "木", "金", "土"]
        let period: [String] = ["1", "2", "3", "4", "5"]
        subjectNameLabel.text = "aaaaaaaaaaaaaaaaaaaaaaaaa"
        classroomLabel.text = "bbbbbbbbbbbbbbbbbbbbbbbbbb"
        teacherLabel.text = "cccccccccc"
        
        switch index {
        case 0 :
            subjectNameLabel.text = ""
        case 1...6 :
            subjectNameLabel.text = week[index - 1]
        case let index where index % 7 == 0:
            subjectNameLabel.text = period[(index / 7) - 1]
        default :
            print("default")
        }
    }
}

class CustomTimeTableCellCreator {
    
    func customizeCollectionView(collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        collectionView.collectionViewLayout = layout
        collectionView.layer.borderColor = UIColor.white.cgColor
        collectionView.layer.borderWidth = 2
    }
    
    func customizeCellDesign(cell: TimeTableCollectionViewCell) -> TimeTableCollectionViewCell {
        cell.backgroundColor = UIColor.rgba(red: 186, green: 193, blue: 234)
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func customizeCellLabelFlowLayout(index: Int, cell: TimeTableCollectionViewCell) -> TimeTableCollectionViewCell {
        let dayOfWeek: [String] = ["月", "火", "水", "木", "金", "土"]
        let period: [String] = ["1", "2", "3", "4", "5"]
        let cellLabel = cell.contentView.viewWithTag(1) as? UILabel
        cellLabel?.textColor = .black
        cellLabel?.textAlignment = .center
        cellLabel?.center.x = cell.frame.width/2.0
        cellLabel?.center.y = cell.frame.height/2.0
        
        switch index {
        case 0:
            cellLabel?.text = ""
        case 1...6:
            cellLabel?.text = dayOfWeek[index - 1]
        case let index where index % 7 == 0:
            cellLabel?.text = period[(index / 7) - 1]
        default:
            cellLabel?.text = ""
        }
    
        return cell
    }
    
    func customizeCellSizeFlowLayout(index: Int, collectionView: UICollectionView) -> CGSize {
        let firstCellOneSideSize: CGFloat = 30.0
        let collectionViewWidth = collectionView.frame.width
        let collectionViewHeight = collectionView.frame.height
        let cellWidth: CGFloat
        let cellHeight: CGFloat
        switch index {
            case 0:
                cellWidth = firstCellOneSideSize
                cellHeight = firstCellOneSideSize
            case 1...6:
                cellWidth = (collectionViewWidth - firstCellOneSideSize - 2*6) / 6.0
                cellHeight = firstCellOneSideSize
            case let index where index % 7 == 0:
                cellWidth = firstCellOneSideSize
                cellHeight = (collectionViewHeight - firstCellOneSideSize - 2*5) / 5.0
            default:
                cellWidth = (collectionViewWidth - firstCellOneSideSize - 2*6) / 6.0
                cellHeight = (collectionViewHeight - firstCellOneSideSize - 2*5) / 5.0
         }
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        return cellSize
    }
    
    func customizeSubjectCellLabelCenter(cell: TimeTableCollectionViewCell) -> TimeTableCollectionViewCell {
        return cell
    }
}
