//
//  NSMutableAttributedString + Extension.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 03.09.2023.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func createAttributedString(_ firstString: String, attributedStr: String, color: UIColor) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = -10
        paragraphStyle.alignment = .center
        var finalString = NSMutableAttributedString(string: firstString, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let secondString = NSAttributedString(string: attributedStr, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        finalString.append(secondString)
        return finalString
    }
}
