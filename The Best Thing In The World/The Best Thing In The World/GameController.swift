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
    
    private var allowsVoting = true
    
    @IBOutlet weak var leftChoice: ContentView!
    @IBOutlet weak var rightChoice: ContentView!
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var starView: StarView!
    
    private var starStartingCenter:CGPoint!
    
    var initialTouchLocation:CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.changeItems()
        
        leftChoice.tag = 1
        rightChoice.tag = 2
        starStartingCenter = starView.center
        
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
                fallthrough
            case .changed:
                let translation = rec.translation(in: self.view)

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
        
        guard allowsVoting else { return }
        
        if leftChoice.frame.contains(point) {
            allowsVoting = false
            print("Escolheu esquerda!")
            animateChoice(leftChoice)
            roundController.increaseVoteItem(itemLeft)
        }
        else if rightChoice.frame.contains(point) {
            allowsVoting = false
            print("Escolheu direita!")
            animateChoice(rightChoice)
            roundController.increaseVoteItem(itemRight)
        }
    }
    
    func pickItem(choice: ContentView) {
        print("Selecionando \(choice.tag)")
    }
    
    func animateChoice(_ choiceView: ContentView) {
    
        let d = 0.7
        
        UIView.animate(withDuration: d,
                       delay: 0,
                       //options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                            self.starView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                            self.starView.center = choiceView.center
                            self.starView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                       }, completion: nil)
        
        UIView.animate(withDuration: d,
                       delay: d/3,
                       //options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                            self.starView.transform = CGAffineTransform(rotationAngle: 3 * CGFloat.pi)
        }, completion: {_ in UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.starView.center = self.starStartingCenter
            self.starView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })})
        
        UIView.animate(withDuration: d,
                       delay: 0,
                       //options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                            choiceView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                            choiceView.backgroundColor = UIColor.blue
                       }, completion: {_ in UIView.animate(withDuration: d,
                                                           animations:{
                                                            choiceView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                                            choiceView.backgroundColor = UIColor.white
                                                        }, completion: { _ in self.updateItems()
                        }) })
        
        
        
    }
    
    @IBAction func reportAction(_ sender: Any) {
        print("i report u")
    }
    
    func updateItems() {
        allowsVoting = true
        changeItems()
    }
    
    func changeItems()
    {
        itemRight = roundController.changeItem()
        
        rightImage.image = UIImage(named: itemRight.getImageLink())
        
        itemLeft = roundController.changeItem()
        
        rightImage.image = UIImage(named: itemLeft.getImageLink())
    }
    
    
    @IBAction func pass(_ sender: Any) {
        guard allowsVoting else { return }
        changeItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

