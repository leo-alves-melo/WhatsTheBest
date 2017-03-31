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
    private var initialTouchLocation:CGPoint?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowRadius = 5.0
        //self.layer.shadowOffset = CGSize(width: 3 , height: 3)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowOpacity = 0.2
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
    }
}
