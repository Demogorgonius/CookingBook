//
//  OnboardingData.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 31.08.2023.
//

import UIKit

struct OnboardingDataModel {
    var backImage = UIImage()
    var text = String()
    var buttonText = String()
    
}

//class AttribitedTextStrings {
//    var text1 = "Recipes from \nall over the \nWorld"
//    let attribitedString1 = NSAttributedString(string: "over the \nWorld", attributes: [NSAttributedString.Key.foregroundColor: UIColor.rating100])
//
//
//}

struct OnboardingDataManager {
    
    static let dataArray : [OnboardingDataModel] = [
        .init(
            backImage: UIImage(named: "onboardingImagePage1")!,
            text: "Recipes from \nall over the \nWorld",
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage2")!,
            text: "Recipes with \neach and every \ndetail",
            buttonText: "Continue"
        ),
        .init(
            backImage: UIImage(named: "onboardingImagePage3")!,
            text: "Cook it now or \nsave it for later",
            buttonText: "Start cooking"
        )
        
    ]
}
