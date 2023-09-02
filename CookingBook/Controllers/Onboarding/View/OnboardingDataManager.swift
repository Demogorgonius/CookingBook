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
            text: NSMutableAttributedString().createString("Recipes from \nall ", "over the \nWorld" , UIColor.secondary20),
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage2")!,
            text: NSMutableAttributedString().createString("Recipes with \n", "each and every \ndetail" , UIColor.secondary20),
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage3")!,
            text: NSMutableAttributedString().createString("Cook it now or \n", "save it for later" , UIColor.secondary20),
            buttonText: "Start cooking"
        )
    ]
    
}

