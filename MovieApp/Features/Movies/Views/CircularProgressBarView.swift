//
//  CircularProgressBarView.swift
//  Task 4
//
//  Created by ME-MAC on 2/16/23.
//

import UIKit

class CircularProgressBarView: UIView {
            
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    var rateValue: CGFloat = 0 {
        didSet {
            progressLayer.strokeEnd = rateValue
        }
    }
    
    func createCircularPath() {
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: 27, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 5
        circleLayer.strokeEnd = 1
        circleLayer.strokeColor = #colorLiteral(red: 0.9230186343, green: 0.8095085621, blue: 0.5659781694, alpha: 1)
        
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5
        progressLayer.strokeEnd = rateValue
        progressLayer.strokeColor = #colorLiteral(red: 0.9450358748, green: 0.6712676883, blue: 0, alpha: 1)
        
        layer.addSublayer(progressLayer)
    }
}
