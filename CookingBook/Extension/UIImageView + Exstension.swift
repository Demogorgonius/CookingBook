//
//  UIImageView + Exstension.swift
//  CookingBook
//
//  Created by Caroline Tikhomirova on 30.08.2023.
//

import UIKit.UIImageView

extension UIImageView {
    func addGradient(_ colors: [UIColor], locations: [NSNumber], frame: CGRect = .zero) {
        
        // Create a new gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the colors and locations for the gradient layer
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.locations = locations
        
        // Set the start and end points for the gradient layer
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        // Set the frame to the layer
        gradientLayer.frame = frame
        
        // Add the gradient layer as a sublayer to the background view
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
