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

class GameController: UIViewController, ItemPicker {

    private var leftViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    private var rightViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    private var roundController = RoundController()
    private var itemRight = Item()
    private var itemLeft = Item()

    
    @IBOutlet weak var leftChoice: ContentView!
    @IBOutlet weak var rightChoice: ContentView!
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var starView: StarView!
    
    var initialTouchLocation:CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftChoice.tag = 1
        rightChoice.tag = 2
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        starView.addGestureRecognizer(pan)
        
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(itemTapAction))
        leftChoice.addGestureRecognizer(tapLeft)
        
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(itemTapAction))
        rightChoice.addGestureRecognizer(tapRight)
        //rightChoice.addGestureRecognizer(tapChoice)
        // Do any additional setup after loading the view, typically from a nib.
        roundController.getItemsFromServer()
    
    }
    
    func panAction(rec: UIPanGestureRecognizer) {
        
        switch rec.state {
            case .began:
                print("began")
                fallthrough
            case .changed:
                
                let translation = rec.translation(in: self.view)
                // note: 'view' is optional and need to be unwrapped
                starView.center = CGPoint(x: starView.center.x + translation.x, y: starView.center.y + translation.y)
                rec.setTranslation(CGPoint.zero, in: self.view)
            case .ended:
                checkIfItemPicked(point: starView.center)
            
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
            animateChoice(leftChoice)
            roundController.increaseVoteItem(itemLeft)
        }
        else if rightChoice.frame.contains(point) {
            print("Escolheu direita!")
            animateChoice(rightChoice)
            roundController.increaseVoteItem(itemRight)

        }
    }
    
    func pickItem(choice: ContentView) {
        print("Selecionando \(choice.tag)")
    }
    
    func animateChoice(_ choiceView: ContentView) {
    
        let d = 0.5
        
        UIView.animate(withDuration: d,
                       delay: 0,
                       //options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                            self.starView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                       }, completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       //options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                            self.starView.transform = CGAffineTransform(rotationAngle: 2 * CGFloat.pi)
                       }, completion: nil)
        
        
        
        
    }
    
    func changeItens()
    {
        itemRight = roundController.changeItem()
        
        rightImage.image = UIImage(named: itemRight.getIdImage())
        
        itemLeft = roundController.changeItem()
        
        rightImage.image = UIImage(named: itemLeft.getIdImage())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

