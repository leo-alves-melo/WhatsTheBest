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
    private var reportingFlag = false
    
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var passButton: UIButton!
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
        
        leftImage.layer.cornerRadius = 10.0
        leftImage.layer.masksToBounds = true
        
        rightImage.layer.cornerRadius = 10.0
        rightImage.layer.masksToBounds = true
        
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
                starStartingCenter = starView.center
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
        starStartingCenter = starView.center
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
        else { starReturningAnimation(false) }
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
                            self.starView.transform = CGAffineTransform(scaleX: 2, y: 2)
                       }, completion: nil)
        
        UIView.animate(withDuration: d,
                       delay: 2*d/7,
                       //options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                            self.starView.transform = CGAffineTransform(rotationAngle: 3 * CGFloat.pi)
        }, completion: { finished in self.starReturningAnimation(finished)
            self.updateItems() })
        
        UIView.animate(withDuration: d,
                       delay: 0,
                       //options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                            choiceView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                            //choiceView.layer.shadowColor = UIColor.orange.cgColor
                       }, completion: {_ in UIView.animate(withDuration: d,
                                                           animations:{
                                                            choiceView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                                            //choiceView.backgroundColor = UIColor.white
                                                        //}, completion: { _ in self.updateItems()
                        }) })
        
        
        
    }
    
    func starReturningAnimation(_ finished: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.starView.center = self.starStartingCenter
            self.starView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    
    @IBAction func reportAction(_ sender: Any) {
        
        if (reportingFlag == true) {
            print("boi")
            self.view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            leftChoice.transform = CGAffineTransform.identity
            rightChoice.transform =  CGAffineTransform.identity
            leftChoice.layer.removeAllAnimations()
            rightChoice.layer.removeAllAnimations()
            /*UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: UIViewAnimationOptions.curveEaseInOut,
                           animations: {
                           self.leftChoice.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)

            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: UIViewAnimationOptions.curveEaseInOut,
                           animations: {
                            self.rightChoice.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)*/
            allowsVoting = true
            reportingFlag = false
            reportButton.setTitle("Report", for: UIControlState.normal)
        }
        else if allowsVoting == true {
            print("oi")
            reportButton.setTitle("Cancel", for: UIControlState.normal)
            reportingFlag = true
            allowsVoting = false
            
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                animations: {
                    self.view.backgroundColor = #colorLiteral(red: 0.159234022, green: 0.1608105964, blue: 0.1608105964, alpha: 1)
            }, completion: nil)
            
            shakeViewClockwise(duration: 0.15, itemView: rightChoice)
            shakeViewClockwise(duration: 0.15, itemView: leftChoice)
        }
    }
    
    func shakeViewClockwise(duration: TimeInterval, itemView: UIView)
    {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        itemView.transform = CGAffineTransform(rotationAngle: -0.10)
        }, completion: { _ in self.shakeViewCounterclockwise(duration: duration, itemView: itemView) })
    }
    
    func shakeViewCounterclockwise(duration: TimeInterval, itemView: UIView)
    {

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        itemView.transform = CGAffineTransform(rotationAngle: 0.10)
        }, completion: { _ in self.shakeViewClockwise(duration: duration, itemView: itemView) })
        
    }
    
    func updateItems() {
        allowsVoting = true
        changeItems()
    }
    
    
    func changeItems()
    {
        let duration = 0.20
        
        itemRight = roundController.changeItem()
        UIView.animate(withDuration: duration,
                       animations: { self.rightImage.alpha = 0.0 },
                       completion: { _ in
                                    self.rightImage.image = UIImage(named: self.itemRight.getImageLink())
                                    UIView.animate(withDuration: duration, animations: {
                                        self.rightImage.alpha = 1.0 })
                                    }
        )
    
        itemLeft = roundController.changeItem()
        UIView.animate(withDuration: duration,
                       animations: { self.leftImage.alpha = 0.0 },
                       completion: { _ in
                        self.leftImage.image = UIImage(named: self.itemLeft.getImageLink())
                        UIView.animate(withDuration: duration, animations: {
                            self.leftImage.alpha = 1.0 })
                        }
        )
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



