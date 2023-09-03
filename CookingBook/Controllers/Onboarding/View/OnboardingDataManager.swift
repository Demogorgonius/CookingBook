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
            text: "Recipes from \nall ",
            attributedText: "over the \nWorld",
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage2")!,
            text: "Recipes with \n",
            attributedText: "each and every \ndetail",
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage3")!,
            text: "Cook it now or \n",
            attributedText: "save it for later",
            buttonText: "Start cooking"
        )
    ]
}

