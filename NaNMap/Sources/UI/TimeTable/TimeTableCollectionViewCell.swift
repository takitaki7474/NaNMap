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
    
    func displayLabel(index: Int) {
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
            print("")
        }
    }
}
