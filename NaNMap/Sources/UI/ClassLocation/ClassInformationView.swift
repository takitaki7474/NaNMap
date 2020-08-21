//
//  ClassInformationView.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/08/01.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

final class ClassInformationView: UIView {
    @IBOutlet weak var courseItemLabel: UILabel!
    @IBOutlet weak var locationItemLabel: UILabel!
    @IBOutlet weak var teacherItemLabel: UILabel!
    @IBOutlet weak var categoryItemLabel: UILabel!
    @IBOutlet weak var semesterItemLabel: UILabel!
    @IBOutlet weak var courseContentLabel: UILabel!
    @IBOutlet weak var locationContentLabel: UILabel!
    @IBOutlet weak var teacherContentLabel: UILabel!
    @IBOutlet weak var categoryContentLabel: UILabel!
    @IBOutlet weak var semesterContentLabel: UILabel!
    var syllabus: TimeTableCellObj?
    
    static func instantiate(frame: CGRect, syllabus: TimeTableCellObj) -> ClassInformationView {
        let view = UINib(nibName: "ClassInformationView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ClassInformationView
        view.syllabus = syllabus
        view.setViewStyle(frame: frame)
        return view
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setViewStyle(frame: CGRect) {
        self.frame = frame
        self.backgroundColor = UIColor.rgba(red: 186, green: 193, blue: 234)
        let lineSpace: CGFloat = 5.0
        let itemWidth: CGFloat = 70.0
        let itemHeight: CGFloat = (frame.height - (lineSpace * 6.0)) / 5.0
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        var point = CGPoint(x: lineSpace, y: lineSpace)
        setItem(label: courseItemLabel, point: point, size: itemSize, text: "Course")
        point.y = point.y + lineSpace + itemHeight
        setItem(label: locationItemLabel, point: point, size: itemSize, text: "Location")
        point.y = point.y + lineSpace + itemHeight
        setItem(label: teacherItemLabel, point: point, size: itemSize, text: "Teacher")
        point.y = point.y + lineSpace + itemHeight
        setItem(label: categoryItemLabel, point: point, size: itemSize, text: "Category")
        point.y = point.y + lineSpace + itemHeight
        setItem(label: semesterItemLabel, point: point, size: itemSize, text: "Semester")
        let contentWidth: CGFloat = frame.width - (itemWidth + lineSpace * 2)
        let contentHeight: CGFloat = itemHeight
        let contentSize = CGSize(width: contentWidth, height: contentHeight)
        point.x = lineSpace + itemWidth - 1.0
        point.y = lineSpace
        setContent(label: courseContentLabel, point: point, size: contentSize, text: syllabus?.subjectName ?? "不明")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: locationContentLabel, point: point, size: contentSize, text: syllabus?.classroom?.classroom ?? "不明")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: teacherContentLabel, point: point, size: contentSize, text: syllabus?.teacher ?? "不明")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: categoryContentLabel, point: point, size: contentSize, text: syllabus?.category ?? "不明")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: semesterContentLabel, point: point, size: contentSize, text: syllabus?.semester ?? "不明")
    }
    
    private func setItem(label: UILabel, point: CGPoint, size: CGSize, text: String) {
        label.frame.origin = point
        label.frame.size = size
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.gray.cgColor
        label.text = text
    }
    
    private func setContent(label: UILabel, point: CGPoint, size: CGSize, text: String) {
        label.frame.origin = point
        label.frame.size = size
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.gray.cgColor
        label.text = text
    }
}
