//
//  ViewController.swift
//  The Best Thing In The World
//
//  Created by Gustavo De Mello Crivelli on 29/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

protocol ItemPicker {
    func checkIfItemPicked(point: CGPoint) //-> Item?
    func pickItem(choice:ContentView)
}

class ViewController: UIViewController, ItemPicker {

    private var leftViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    private var rightViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    
    
    
    @IBOutlet weak var leftChoice: ContentView!
    @IBOutlet weak var rightChoice: ContentView!
    
    @IBOutlet weak var starView: StarView!
    
    var initialTouchLocation:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starView.setDelegate(delegate: self)
        
        leftChoice.tag = 1
        rightChoice.tag = 2
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        //starView.addGestureRecognizer(pan)
        
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(itemTapAction))
        leftChoice.addGestureRecognizer(tapLeft)
        
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(itemTapAction))
        rightChoice.addGestureRecognizer(tapRight)
        //rightChoice.addGestureRecognizer(tapChoice)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func panAction(rec: UIPanGestureRecognizer) {
        
        let p:CGPoint = rec.location(in: self.view)
        
        switch rec.state {
            case .began:
                print("began")
                initialTouchLocation = rec.location(ofTouch: 0, in: starView)
            case .changed:
                starView.center = CGPoint(x: p.x, y: p.y)
            case .ended:
                checkIfItemPicked(point: p)
            
            default: break
        }
    }
    
    func itemTapAction(sender : UITapGestureRecognizer) {
        checkIfItemPicked(point: sender.location(ofTouch: 0, in: self.view))
        //pickItem(choice: sender)
    }
    
    func checkIfItemPicked(point: CGPoint) /*-> Item? */{
        print(point)
        if leftChoice.frame.contains(point) {
            print("Escolheu esquerda!")
            animateStar()
        }
        else if rightChoice.frame.contains(point) {
            print("Escolheu direita!")
            animateStar()
        }
    }
    
    func pickItem(choice: ContentView) {
        print("Selecionando \(choice.tag)")
    }
    
    func animateStar() {
        
        /*CATransaction.begin()
         CATransaction.setCompletionBlock({
         
         })*/
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.duration = 0.5
        rotation.toValue = 2 * CGFloat.pi
        
        /*let growth = CABasicAnimation(keyPath: "bounds.rotation")
         rotation.fromValue = 0.0
         rotation.duration = 0.5
         rotation.toValue = 2 * CGFloat.pi*/
        
        starView.layer.add(rotation, forKey: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

