//
//  HangmanView.swift
//  Hangman
//
//  Created by Julia Friberg on 2017-06-22.
//  Copyright © 2017 Julia Friberg. All rights reserved.
//

import UIKit

class HangmanDrawingView: UIView {
    
    var partLayers = [CAShapeLayer]()
    
    let standardWidthScale: CGFloat = 0.15
    let standardHeightScale: CGFloat = 0.18
    
    func clear() {
        
        for layer in partLayers {
            layer.removeFromSuperlayer()
        }
        partLayers.removeAll()
    }
    
    func add(part: HangmanDrawingPart){
        
        let newPartLayer = CAShapeLayer()
        
        let partPath = path(forPart: part)
        newPartLayer.frame = bounds
        newPartLayer.path = partPath.cgPath
        newPartLayer.strokeColor = UIColor.black.cgColor
        newPartLayer.fillColor = UIColor.clear.cgColor
        
        newPartLayer.lineCap = kCALineCapRound
        newPartLayer.lineWidth = 2
        
        let strokeAnim = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnim.fromValue = 0
        strokeAnim.toValue = 1
        strokeAnim.duration = 1
        layer.addSublayer(newPartLayer)
        newPartLayer.add(strokeAnim, forKey: "path")
        partLayers.append(newPartLayer)
        
    }
    
    func path(forPart: HangmanDrawingPart) -> UIBezierPath {
        
        let standardWidth = bounds.width * standardWidthScale
        let standardHeight = bounds.height * standardHeightScale
        
        switch forPart {
            
        case .gallowBase:
            let startPoint = CGPoint(x: center.x - standardWidth, y: bounds.maxY)
            let endPoint = CGPoint(x: center.x, y: startPoint.y)
            return getLinePath(from: startPoint, to: endPoint)
        
        case .gallowHeight:
            let startPoint = CGPoint(x: center.x - standardWidth/2, y: bounds.maxY)
            let endPoint = CGPoint(x: center.x - standardWidth/2, y: bounds.minY)
            return getLinePath(from: startPoint, to: endPoint)

        case .gallowAcross:
            let startPoint = CGPoint(x: center.x - standardWidth/2, y: bounds.minY)
            let endPoint = CGPoint(x: startPoint.x + standardWidth, y: startPoint.y)
            return getLinePath(from: startPoint, to: endPoint)
            
        case .gallowTip:
            let startPoint = CGPoint(x: center.x + standardWidth/2, y: bounds.minY)
            let endPoint = CGPoint(x: startPoint.x , y: startPoint.y + standardHeight)
            return getLinePath(from: startPoint, to: endPoint)
            
        case .head:
            let headCenter = CGPoint(x: center.x + standardWidth/2, y: standardHeight * 1.5)
            let path = UIBezierPath(arcCenter: headCenter, radius: standardHeight/2, startAngle: CGFloat(0), endAngle: CGFloat(2 * Double.pi), clockwise: true)
            
            return path
            
        case .body:
            let startPoint = CGPoint(x: center.x + standardWidth/2, y: standardHeight * 2)
            let endPoint = CGPoint(x: startPoint.x , y: standardHeight * 4)
            return getLinePath(from: startPoint, to: endPoint)
            
        case .leftLeg:
            let startPoint = CGPoint(x: center.x + standardWidth/2, y: standardHeight * 4)
            let endPoint = CGPoint(x: startPoint.x - standardWidth/4, y: standardHeight * 5)
            return getLinePath(from: startPoint, to: endPoint)
            
        case .rightLeg:
            let startPoint = CGPoint(x: center.x + standardWidth/2, y: standardHeight * 4)
            let endPoint = CGPoint(x: startPoint.x + standardWidth/4, y: standardHeight * 5)
            return getLinePath(from: startPoint, to: endPoint)
            
        case .leftArm:
            let startPoint = CGPoint(x: center.x + standardWidth/2, y: standardHeight * 2.5)
            let endPoint = CGPoint(x: startPoint.x - standardWidth/4, y: standardHeight * 3.5)
            return getLinePath(from: startPoint, to: endPoint)
            
        case .rightArm:
            let startPoint = CGPoint(x: center.x + standardWidth/2, y: standardHeight * 2.5)
            let endPoint = CGPoint(x: startPoint.x + standardWidth/4, y: standardHeight * 3.5)
            return getLinePath(from: startPoint, to: endPoint)
        }
    }
    
    func getLinePath(from startPoint: CGPoint, to endPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
}

