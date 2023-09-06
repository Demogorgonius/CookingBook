//
//  CustomView.swift
//  CookingBook
//
//  Created by Miras Maratov on 03.09.2023.
//

import UIKit

class CustomView: UIView {
// MARK: - property
    private let minimumPossibleHeight: CGFloat = 85
    var pathColor: UIColor = .white { didSet { setNeedsDisplay() }}
    
// MARK: - lifecycle funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureUI()
    }

    override func draw(_ rect: CGRect) {
        pathColor.setFill()
        let path = UIBezierPath()
        let startPoint = CGPoint(x: rect.minX, y: rect.minY)
        path.move(to: startPoint)
        let sideCurveEnd = CGPoint(x: 0, y: 0)
        let sideCurveCP = CGPoint(x: startPoint.x, y: sideCurveEnd.y)
        path.addQuadCurve(to: sideCurveEnd, controlPoint: sideCurveCP)
        let centerArcBegin = CGPoint(x: rect.midX - 45, y: sideCurveEnd.y)
        path.addLine(to: centerArcBegin)
        let centerFirstArcEnd = CGPoint(x: centerArcBegin.x + 15, y: centerArcBegin.y + 10)
        let centerFirstArcCP = CGPoint(x: centerFirstArcEnd.x - 5, y: centerArcBegin.y)
        path.addQuadCurve(to: centerFirstArcEnd, controlPoint: centerFirstArcCP)
        let centerSecondArcEnd = CGPoint(x: rect.midX + 1, y: centerFirstArcEnd.y + 20)
        let centerSecondArcCP = CGPoint(x: centerFirstArcEnd.x + 5, y: centerFirstArcEnd.y + 10)
        let centerSecondArcCP2 = CGPoint(x: centerFirstArcEnd.x + 15, y: centerSecondArcEnd.y)
        path.addCurve(to: centerSecondArcEnd, controlPoint1: centerSecondArcCP, controlPoint2: centerSecondArcCP2)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()
        path.fill()
// Зеркало:
        let mirrorPath = path
        mirrorPath.apply(CGAffineTransform(scaleX: -1, y: 1))
        mirrorPath.apply(CGAffineTransform(translationX: rect.width, y: 0))
        mirrorPath.fill()
    }
    
// MARK: - flow func
    private func configureUI() {
        backgroundColor = .clear
        heightAnchor.constraint(greaterThanOrEqualToConstant: minimumPossibleHeight).isActive = true
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: -4)
        layer.shadowOpacity = 0.2
    }
}

