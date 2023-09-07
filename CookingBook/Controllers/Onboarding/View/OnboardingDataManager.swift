//
//  OnboardingDataManager.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 02.09.2023.
//

import Foundation
import UIKit


struct OnboardingDataManager {
    
    static let dataArray : [OnboardingDataModel] = [
        .init(
            backImage: UIImage(named: "onboardingImagePage1")!,
            text: NSMutableAttributedString().createAttributedString("Recipes from \nall ", attributedStr: "over the \nWorld", color: .rating100),
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage2")!,
            text: NSMutableAttributedString().createAttributedString("Recipes with \n", attributedStr: "each and every \ndetail", color: .rating100),
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage3")!,
            text: NSMutableAttributedString().createAttributedString("Cook it now or \n", attributedStr: "save it for later", color: .rating100),
            buttonText: "Start cooking"
        )
    ]
}
