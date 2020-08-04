//
//  ClassInformationView.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/08/01.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class ClassInformationView: UIView {
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
    
    static func instantiate(frame: CGRect) -> ClassInformationView {
        let view = UINib(nibName: "ClassInformationView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ClassInformationView
        view.setViewStyle(frame: frame)
        return view
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setViewStyle(frame: CGRect) {
        self.frame = frame
        self.backgroundColor = .blue
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
        point.x = lineSpace + itemWidth
        point.y = lineSpace
        setContent(label: courseContentLabel, point: point, size: contentSize, text: "aaaa")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: locationContentLabel, point: point, size: contentSize, text: "bbbb")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: teacherContentLabel, point: point, size: contentSize, text: "cccc")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: categoryContentLabel, point: point, size: contentSize, text: "dddd")
        point.y = point.y + lineSpace + itemHeight
        setContent(label: semesterContentLabel, point: point, size: contentSize, text: "eeee")
    }
    
    private func setItem(label: UILabel, point: CGPoint, size: CGSize, text: String) {
        label.frame.origin = point
        label.frame.size = size
        label.backgroundColor = .gray
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = text
    }
    
    private func setContent(label: UILabel, point: CGPoint, size: CGSize, text: String) {
        label.frame.origin = point
        label.frame.size = size
        label.backgroundColor = .purple
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = text
    }
}
