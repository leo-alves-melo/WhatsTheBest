//
//  StarView.swift
//  The Best Thing In The World
//
//  Created by Gustavo De Mello Crivelli on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class StarView : UIView {
    
    var delegate:ItemPicker?
    var initialTouchLocation:CGPoint!
    
    private func operateCGPoints(_ a: CGPoint, _ b: CGPoint, _ op: (CGFloat, CGFloat) -> CGFloat) -> CGPoint {
        return CGPoint(x: op(a.x, b.x), y: op(a.y, b.y))
    }
    
    public func setDelegate(delegate: ItemPicker) {
            self.delegate = delegate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {

        super.touchesBegan(touches, with: with)

        let touch:UITouch = touches.first! as UITouch

        self.initialTouchLocation = touch.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {

        super.touchesMoved(touches, with: with)

        let touch: UITouch = touches.first! as UITouch

        self.center = operateCGPoints(self.center,
                                      operateCGPoints(
                                        initialTouchLocation!,
                                        touch.location(in: self),
                                        {a, b in b - a}),
                                      {a, b in a + b})
        initialTouchLocation = touch.location(in: self)
        //print(touch.location(in: self))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {

        super.touchesEnded(touches, with: with)

        let touch: UITouch = touches.first! as UITouch
        
        print(touch.location(in: self))
        
        if let del = delegate {
            print("checando")
            del.checkIfItemPicked(point: self.center)
        }
    }
}
