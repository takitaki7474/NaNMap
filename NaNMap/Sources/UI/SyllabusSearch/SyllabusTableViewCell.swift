//
//  CustomSyllabusCell.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/07/07.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

class SyllabusTableViewCell: UITableViewCell {
    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var classroomLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    
    func display(semester: String) {
        semesterLabel.text = semester
    }
    
    func display(subjectName: String) {
        subjectLabel.text = subjectName
    }
    
    func display(classroom: String) {
        classroomLabel.text = classroom
    }
    
    func display(teacher: String) {
        teacherLabel.text = teacher
    }
}

