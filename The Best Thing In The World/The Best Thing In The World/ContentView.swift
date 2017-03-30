//
//  ContentView.swift
//  The Best Thing In The World
//
//  Created by Gustavo De Mello Crivelli on 29/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class ContentView : UIView {
    
    //Define your initialisers here
    
    private var centerOffset:CGPoint = CGPoint(x: 0, y:0)
    
   /* override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        if let touch = touches.first as UITouch {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }
    } */
    
    private func operateCGPoints(_ a: CGPoint, _ b: CGPoint, _ op: (CGFloat, CGFloat) -> CGFloat) -> CGPoint {
        return CGPoint(x: op(a.x, b.x), y: op(a.y, b.y))
    }
    
    func setOffset(_ newOffset: CGPoint) {
        
        let localCenter = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        
        centerOffset = operateCGPoints(localCenter, newOffset, {a, b in a - b})
        print("Inner coordinates: \(newOffset) - Relative to center: \(centerOffset)")
    }
    
    func moveToWithOffset(_ newPos: CGPoint) {
        self.center = operateCGPoints(newPos, centerOffset, {a, b in a + b})
    }
    
    func animate(tempo:TimeInterval) {
        
        /*CATransaction.begin()
        CATransaction.setCompletionBlock({
            
        })*/
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.duration = tempo
        rotation.toValue = 2 * CGFloat.pi
        
        /*let growth = CABasicAnimation(keyPath: "bounds.rotation")
        rotation.fromValue = 0.0
        rotation.duration = 0.5
        rotation.toValue = 2 * CGFloat.pi*/
        
        self.layer.add(rotation, forKey: nil)
    }
    
}
