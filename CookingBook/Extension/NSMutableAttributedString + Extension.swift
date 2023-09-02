//
//  NSMutableAttributedString + Extension.swift
//  CookingBook
//
//  Created by Sergey on 02.09.2023.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func createString(_ fString: String, _ sString: String, _ color: UIColor) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        paragraphStyle.alignment = .center
        let finalString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let stringAtrColor = [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let string = NSMutableAttributedString(string: fString ,attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                                             NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let atrString = NSMutableAttributedString(string: sString ,attributes: stringAtrColor)
        finalString.append(string)
        finalString.append(atrString)
        
        return finalString
    }
}
