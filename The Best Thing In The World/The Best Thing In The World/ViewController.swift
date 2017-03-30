//
//  ViewController.swift
//  The Best Thing In The World
//
//  Created by Gustavo De Mello Crivelli on 29/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var leftViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    private var rightViewCenterOffset:CGPoint = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var leftChoice: ContentView!
    @IBOutlet weak var rightChoice: ContentView!
    
    @IBOutlet weak var starView: ContentView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftChoice.layer.cornerRadius = 10.0
        leftChoice.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        leftChoice.layer.shadowRadius = 5.0
        
        
        rightChoice.layer.cornerRadius = 10.0
        
        
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(imagePressed(sender:)))
        
        //leftChoice.addGestureRecognizer(tap)
        //rightChoice.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        
        super.touchesBegan(touches, with: with)
        
        let touch:UITouch = touches.first! as UITouch
        
        if let choice = touch.view as? ContentView {
            choice.setOffset(touch.location(in: touch.view))
        }else{
            print("touchesBegan | This is not a choice!")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        
        super.touchesMoved(touches, with: with)
        
        let touch: UITouch = touches.first! as UITouch
        
        if let choice = touch.view as? ContentView {
            choice.moveToWithOffset(touch.location(in: self.view))
        } else {
            print("touchesMoved | This is not a choice!")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with: UIEvent?) {
        
        super.touchesEnded(touches, with: with)
        
        let touch: UITouch = touches.first! as UITouch
        
        if let choice = touch.view as? ContentView {
            if choice == starView {
                if rightChoice.frame.contains(choice.center) {
                    print("selecionou a direita!")
                    let tempo:TimeInterval = 0.5
                    choice.animate(tempo: tempo)
                    
                    UIView.animate(withDuration: tempo/2, animations: {
                        choice.transform = CGAffineTransform(scaleX: 2,y: 2)
                    }, completion: { _ in
                        UIView.animate(withDuration: tempo/2,
                                       animations: {
                                            choice.transform = CGAffineTransform(scaleX: 1, y: 1)
                        })
                    })
                }
                if leftChoice.frame.contains(choice.center) {
                    print("selecionou a esquerda!")
                }
            }
        }else {
            print("touchesEnded | This is not an ImageView")
        }
    }
    
    /*internal func imagePressed(sender: UITapGestureRecognizer) {
        sender.
    }*/

}

