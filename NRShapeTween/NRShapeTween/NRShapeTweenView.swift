//
//  NRShapeTweenView.swift
//  NRShapeTween
//
//  Created by Nutchaphon Rewik on 7/25/15.
//  Copyright (c) 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

@IBDesignable class NRShapeTweenView: UIView {
    
    @IBInspectable var borderColor: UIColor?{
        didSet{
            shapeLayer.strokeColor = borderColor?.CGColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1.0{
        didSet{
            shapeLayer.lineWidth = borderWidth
        }
    }
    @IBInspectable var fillColor: UIColor?{
        didSet{
            shapeLayer.fillColor = fillColor?.CGColor
        }
    }
    
    @IBInspectable var side: Float = 3.0{
        didSet{
            assert( side >= 1.0, "side must be greater than 1.0")
            _setSide(side)
            currentSide = side
        }
    }
    private var currentSide: Float = 3.0
    private var nextSide: Float = 3.0
    private var duration = 1.0
    private var beginTime = CACurrentMediaTime()
    
    private func pointsForShapeWithSide(side: Int,center: CGPoint,radius: CGFloat, resolution: Int = 250) -> [CGPoint]{
        
        let range = CGFloat(resolution) / CGFloat(side)
        
        let eachRadian = 2.0 * CGFloat(M_PI) / CGFloat(side)
        
        var beginRadian: CGFloat = 0.0
        if side <= 3{
            beginRadian = -CGFloat(M_PI_2)
        }else if side == 4{
            beginRadian = -CGFloat(M_PI_4)
        }else{
            beginRadian = CGFloat(M_PI_2) * CGFloat(side)
        }
        
        var points = [CGPoint]()
        for i in 0..<resolution{

            var percentage = ( CGFloat(i) % range ) / range

            let currentSide = Int( Double(i) / Double(resolution) * Double(side) )
            
            let beginX = center.x + radius * cos( eachRadian * CGFloat(currentSide) + beginRadian )
            let beginY = center.y + radius * sin( eachRadian * CGFloat(currentSide) + beginRadian )
            
            let endX = center.x + radius * cos( eachRadian * CGFloat(currentSide+1) + beginRadian )
            let endY = center.y + radius * sin( eachRadian * CGFloat(currentSide+1) + beginRadian )
            
            let x = beginX + (endX-beginX) * percentage
            let y = beginY + (endY-beginY) * percentage
            
            let point = CGPoint(x: x, y: y)
            points += [point]
        }
        return points
    }
    
    private func interpolatedPoint( #beginPoint: CGPoint, endPoint: CGPoint, interpolate: CGFloat) -> CGPoint{
        
        let x = beginPoint.x + ( endPoint.x - beginPoint.x ) * interpolate
        let y = beginPoint.y + ( endPoint.y - beginPoint.y ) * interpolate
        
        return CGPoint(x: x, y: y)
    }
    
    private func drawShapeWithSide(side: Int, toSide: Int,interpolate: CGFloat) -> CGPathRef{
        
        let height = frame.size.height
        let width = frame.size.width
        
        let center = CGPoint(x: width/2.0, y: height/2.0)
        let radius = min(height/2.0, width/2.0)
        
        var oldPoints = pointsForShapeWithSide(side, center: center, radius: radius)
        var newPoints = pointsForShapeWithSide(toSide, center: center, radius: radius)
        
        assert(oldPoints.count > 0, "points size must be greater than 0")
        assert(newPoints.count > 0, "points size must be greater than 0")

        let path = UIBezierPath()
        
        //begin path
        let beginPoint = interpolatedPoint(beginPoint: oldPoints[0], endPoint: newPoints[0], interpolate: interpolate)
        path.moveToPoint(beginPoint)
        
        //join line to path
        for i in 1..<oldPoints.count{
            let point = interpolatedPoint(beginPoint: oldPoints[i], endPoint: newPoints[i], interpolate: interpolate)
            path.addLineToPoint(point)
        }
        path.closePath()
        
        return path.CGPath
    }
    
    func _update(){
        let currentTime = CACurrentMediaTime()
        
        let t = Float(currentTime - beginTime) / Float(duration)
        
        let nowSide = (1.0-t)*currentSide + nextSide * t
        _setSide(nowSide)
        if currentTime - beginTime > duration{
            displayLink.paused = true
            currentSide = nextSide
        }
    }
    
    func animateToSide(side : Float, duration: Double = 1.0){
        assert( side >= 1.0, "side must be greater than 1.0")
        
        self.duration = duration
        nextSide = side
        beginTime = CACurrentMediaTime()
        displayLink.paused = false
    }
    
    private func _setSide(side: Float){
        let lowerSide = Int(side)
        let upperSide = lowerSide + 1
        let interpolate = CGFloat(side) - CGFloat(lowerSide)
        shapeLayer.path = drawShapeWithSide(lowerSide, toSide: upperSide, interpolate: interpolate)
    }
    
    private func setupComponents(){
        layer.addSublayer(shapeLayer)
        layer.masksToBounds = false
        shapeLayer.masksToBounds = false
    }
    
    private lazy var displayLink: CADisplayLink = {
        let _displayLink = CADisplayLink(target: self, selector: "_update")
        _displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        return _displayLink
        }()
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupComponents()
    }
    
    
}
