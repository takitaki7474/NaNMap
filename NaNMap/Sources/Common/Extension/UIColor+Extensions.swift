//
//  File.swift
//  NaNMap
//
//  Created by 太田龍之介 on 2020/04/08.
//  Copyright © 2020 ryunosuke ota. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgba(red: Int, green: Int, blue: Int, alpha: Float = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
