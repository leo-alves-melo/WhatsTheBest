//
//  ViewController.swift
//  WhatsTheBest
//
//  Created by Leonardo Alves de Melo on 3/29/17.
//  Copyright © 2017 Leonardo Alves de Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chooserButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        chooserButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "moveChooser:"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveChooser(pan: UIPanGestureRecognizer) {
        
    }


}

