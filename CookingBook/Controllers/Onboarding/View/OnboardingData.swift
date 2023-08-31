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

struct OnboardingDataManager {
    static let dataArray : [OnboardingDataModel] = [
        .init(backImage: UIImage(named: "onboardingImagePage1")!, text: "Recipes from all over the World", buttonText: "Continue"),
        .init(backImage: UIImage(named: "onboardingImagePage2")!, text: "Recipes with each and every detail", buttonText: "Continue"),
        .init(backImage: UIImage(named: "onboardingImagePage3")!, text: "Cook it now or save it for later", buttonText: "Start cooking")
        
        ]
    }
