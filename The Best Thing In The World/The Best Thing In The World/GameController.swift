//
//  ViewController.swift
//  The Best Thing In The World
//
//  Created by Gustavo De Mello Crivelli on 29/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit
import AVFoundation

protocol ItemPicker {
    func checkIfItemPicked(point: CGPoint) //-> Item?
    func pickItem(choice:ContentView)
}

class GameController: UIViewController, ItemPicker {

    var choiceSound = URL(fileURLWithPath: Bundle.main.path(forResource: "choice", ofType: "wav")!)
    var choiceAudioPlayer:AVAudioPlayer!
    
    var reportSound = URL(fileURLWithPath: Bundle.main.path(forResource: "report", ofType: "wav")!)
    var reportAudioPlayer:AVAudioPlayer!
    
    var bgSound = URL(fileURLWithPath: Bundle.main.path(forResource: "bg", ofType: "mp3")!)
    var bgAudioPlayer:AVAudioPlayer!
    
    private var leftViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    private var rightViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    private var roundController = RoundController()
    
    private var itemRight = Item()
    private var itemLeft = Item()
    
    private var allowsVoting = true
    private var reportingFlag = false
    
    private var originalReportWidth:CGFloat = 0
    private var originalPassMaxX:CGFloat = 0
    
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var leftChoice: ContentView!
    @IBOutlet weak var rightChoice: ContentView!

    @IBOutlet weak var subImageRight: UILabel!
    @IBOutlet weak var subImageLeft: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var starView: StarView!
    
    @IBOutlet weak var starCircle: UIImageView!
    
    @IBOutlet weak var lblGameTalk: UILabel!
    private var starSetCenterFlag = true
    private var starStartingCenter:CGPoint!
    
    var initialTouchLocation:CGPoint!
    
    private var sentences:[String:String] = [:]
    private var playSoung:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()

        lblGameTalk.text = ""

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
        self.changeItems(3)
        self.sentences = roundController.loadSentences()
        
        //prepares the sound effect
        do {
            try choiceAudioPlayer = AVAudioPlayer(contentsOf: choiceSound)
                choiceAudioPlayer.prepareToPlay()
            try reportAudioPlayer = AVAudioPlayer(contentsOf: reportSound)
                reportAudioPlayer.prepareToPlay()
            try bgAudioPlayer = AVAudioPlayer(contentsOf: bgSound)
                bgAudioPlayer.prepareToPlay()
        }
        catch {
            print("Error: sound not loaded")
        }
        
        originalReportWidth = reportButton.bounds.width
        originalPassMaxX = passButton.bounds.maxX
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
        super.viewDidAppear(animated)
        
        bgAudioPlayer.numberOfLoops = -1
        bgAudioPlayer.play()
        

        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = 2.0
        rotateAnimation.repeatCount = FLT_MAX;
        
        starCircle.layer.add(rotateAnimation, forKey: nil)
    
    }

    /*  music plays while app is minimized */
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        bgAudioPlayer.stop()
        //starCircle.layer.removeAllAnimations()
    }
    
    
    func panAction(rec: UIPanGestureRecognizer) {
        
        switch rec.state {
            case .began:
                if self.starSetCenterFlag {
                    print("oi")
                    starStartingCenter = starView.center
                    self.starSetCenterFlag = false
                }
                fallthrough
            case .changed:
                if reportingFlag { break }
                let translation = rec.translation(in: self.view)

                starView.center = CGPoint(x: starView.center.x + translation.x, y: starView.center.y + translation.y)
                rec.setTranslation(CGPoint.zero, in: self.view)
            case .ended:
                checkIfItemPicked(point: starView.center)
            default: break
        }
    }
    
    func itemTapAction(sender : UITapGestureRecognizer) {
        print("oi")
        if self.starSetCenterFlag {
            starStartingCenter = starView.center
            self.starSetCenterFlag = false
        }
        
        checkIfItemPicked(point: sender.location(ofTouch: 0, in: self.view))
        //pickItem(choice: sender)
    }
    
    func checkIfItemPicked(point: CGPoint) /*-> Item? */{
        
<<<<<<< HEAD
        if reportingFlag {
            
            if leftChoice.frame.contains(point) {
                report(choice: leftChoice, item: itemLeft)
            }
            else if rightChoice.frame.contains(point) {
                report(choice: rightChoice, item: itemRight)
            }
        }
        else if allowsVoting {
        
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
=======
        guard allowsVoting else { return }
        
        if leftChoice.frame.contains(point) {
            allowsVoting = false
            print("Escolheu esquerda!")
            animateChoice(leftChoice)
            roundController.increaseVoteItem(itemLeft)
            lblGameTalk.text = sentences[itemLeft.getImageLink()]

        }
        else if rightChoice.frame.contains(point) {
            allowsVoting = false
            print("Escolheu direita!")
            animateChoice(rightChoice)
            roundController.increaseVoteItem(itemRight)
            lblGameTalk.text = sentences[itemRight.getImageLink()]

>>>>>>> 1e9549a0ed24618789959cf0b66ec6a84fd6967e
        }
        else { starReturningAnimation(false) }
    }
    
    func pickItem(choice: ContentView) {
        print("Selecionando \(choice.tag)")
    }
    
    func animateChoice(_ choiceView: ContentView) {
    
        let d = 0.7
        choiceAudioPlayer.play()
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
            self.updateItems(whichItems: 3) })
        
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

    
    func report(choice: ContentView, item: Item) {
        changeItems(choice.tag)
        cancelReportAction()
        
    }
    
    func cancelReportAction() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
                        self.leftChoice.layer.borderColor = #colorLiteral(red: 0, green: 0.5182169676, blue: 0.5800015926, alpha: 1).cgColor
                        self.rightChoice.layer.borderColor = #colorLiteral(red: 0, green: 0.5182169676, blue: 0.5800015926, alpha: 1).cgColor
                        self.reportButton.frame = CGRect(x: self.reportButton.frame.minX,
                                                         y: self.reportButton.frame.minY,
                                                         width: self.originalReportWidth,
                                                         height: self.reportButton.frame.height)
        }, completion: nil)
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        leftChoice.layer.removeAllAnimations()
        rightChoice.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.leftChoice.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.rightChoice.transform =  CGAffineTransform.identity
        }, completion: nil)
        allowsVoting = true
        reportingFlag = false
        reportButton.setTitle("Report", for: UIControlState.normal)
    }
    
    @IBAction func reportAction(_ sender: Any) {
        
        if (reportingFlag == true) {
            cancelReportAction()
        }
        else if allowsVoting == true {
            
            reportButton.setTitle("Cancel", for: UIControlState.normal)
            reportingFlag = true
            allowsVoting = false
            reportAudioPlayer.play()
            
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                animations: {
                    self.reportButton.frame = CGRect(x: self.reportButton.frame.minX, y: self.reportButton.frame.minY,
                                                    width: 324.0 - 53.0,//self.passButton. - self.reportButton.bounds.minX,
                                                    height: self.reportButton.frame.height)
                    self.leftChoice.layer.borderColor = #colorLiteral(red: 0.6, green: 0.2, blue: 0.3137254902, alpha: 1).cgColor
                    self.rightChoice.layer.borderColor = #colorLiteral(red: 0.6, green: 0.2, blue: 0.3137254902, alpha: 1).cgColor
            }, completion: nil)
            
            shakeViewClockwise(duration: 0.15, itemView: rightChoice)
            shakeViewClockwise(duration: 0.15, itemView: leftChoice)
        }
    }
    
    func shakeViewClockwise(duration: TimeInterval, itemView: UIView)
    {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        itemView.transform = CGAffineTransform(rotationAngle: -0.10)
        }, completion: { finished in if finished {
                self.shakeViewCounterclockwise(duration: duration, itemView: itemView)
            } })
    }
    
    func shakeViewCounterclockwise(duration: TimeInterval, itemView: UIView)
    {

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        itemView.transform = CGAffineTransform(rotationAngle: 0.10)
        }, completion: { finished in if finished {
            self.shakeViewClockwise(duration: duration, itemView: itemView)
            } })
        
    }
    
<<<<<<< HEAD
    func updateItems(whichItems: Int) {
=======
    func updateItems() {
        
        lblGameTalk.text = ""
>>>>>>> 1e9549a0ed24618789959cf0b66ec6a84fd6967e
        allowsVoting = true
        changeItems(whichItems)
    }
    
    
    func changeItems(_ whichItems:Int)
    {
        let duration = 0.20
        
        if whichItems == 1 || whichItems == 3 {
            itemLeft = roundController.changeItem()
            UIView.animate(withDuration: duration,
                           animations: {
                                self.leftImage.alpha = 0.0
                                if self.reportingFlag {
                                        self.leftChoice.backgroundColor = #colorLiteral(red: 0.6, green: 0.2, blue: 0.3137254902, alpha: 1)
                                }},
                           completion: { _ in
                            self.leftImage.image = UIImage(named: self.itemLeft.getImageLink())
                            UIView.animate(withDuration: duration, animations: {
                                self.leftImage.alpha = 1.0
                                self.leftChoice.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                })
            }
            )
            subImageLeft.text = itemLeft.getSubtitle()
        }
        
        if whichItems == 2 || whichItems == 3 {
            
            itemRight = roundController.changeItem()
            UIView.animate(withDuration: duration,
                           animations: { self.rightImage.alpha = 0.0
                                        if self.reportingFlag {
                                            self.rightChoice.backgroundColor = #colorLiteral(red: 0.6, green: 0.2, blue: 0.3137254902, alpha: 1)
                                        }},
                           completion: { _ in
                                        self.rightImage.image = UIImage(named: self.itemRight.getImageLink())
                                        UIView.animate(withDuration: duration, animations: {
                                            self.rightImage.alpha = 1.0
                                            self.rightChoice.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                            })
                                        }
            )
            subImageRight.text = itemRight.getSubtitle()
        }
        
        changeGameLabelText(whichItems)
    }
    
    func changeGameLabelText(_ modifier:Int) {
        var indexRandom:Int
        indexRandom = Int(arc4random_uniform(UInt32(2)))
        if(indexRandom == 0)
        {
            //lblGameTalk.text = sentences[itemLeft.getImageLink()]
        }
        else {
            //lblGameTalk.text = sentences[itemRight.getImageLink()]
        }
    }
    
    
    @IBAction func pass(_ sender: Any) {
        guard allowsVoting else { return }
        changeItems(3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func btnMute(_ sender: UIButton) {
        
        if(bgAudioPlayer.isPlaying)
        {
            bgAudioPlayer.stop()
        }
        
        else {
            bgAudioPlayer.play()
        }
        
        
    }
}



