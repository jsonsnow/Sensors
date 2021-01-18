//
//  common_label.swift
//  WGCommon
//
//  Created by chen liang on 2021/1/5.
//

import UIKit

public extension UILabel {
    static func factoryLabel(fonSize: Float, color: UIColor, numberOflines: Int = 0) -> UILabel {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: CGFloat(fonSize))
        label.textColor = color
        label.numberOfLines = numberOflines
        return label
    }
}
