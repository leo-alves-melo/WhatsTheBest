//
//  ProfileViewController.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 05/04/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var serverService = ServerService.sharedInstance

    private var user:User = User()
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var txtSubmissions: UILabel!
    private var itens:[Item] = []
    
    
    @IBOutlet weak var viewSubmissions: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = serverService.getCurrentUser()
        
        itens=serverService.getAllUserItens(user)!
    
        // Do any additional setup after loading the view.
        self.imgProfile.layer.cornerRadius = 8.0
        
        self.imgProfile.layer.shadowOpacity = 0.2
        self.imgProfile.layer.shouldRasterize = true
        self.imgProfile.layer.rasterizationScale = UIScreen.main.scale
        self.imgProfile.layer.masksToBounds = false
        
        self.viewTitle.layer.masksToBounds = false
        self.viewTitle.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewTitle.layer.shadowOffset = CGSize(width: 0.0, height: 0.4)
        self.viewTitle.layer.shadowOpacity = 1.0
        self.viewTitle.layer.shadowRadius = 0.0
        
        let borderTop = CALayer()
        borderTop.borderColor = UIColor.lightGray.cgColor
        borderTop.frame = CGRect(x: 0, y: 0 , width: self.collectionView.frame.width, height: 1)
        borderTop.borderWidth = 1
        self.viewSubmissions.layer.addSublayer(borderTop)
        self.viewSubmissions.layer.masksToBounds = true
        
        userScore.text = String(user.getScore())
        
    
        
        
        
      //  self.viewTitle.layer.backgroundColor = UIColor.white.cgColor
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userScore.text = String(user.getScore())
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itens.count
    }
    
  

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! colwCell
        
        //let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: <#T##IndexPath#>) as! colwCell
        
        
      
        cell.lblCell.text = itens[indexPath.row].getSubtitle()
        cell.imgCell.image = UIImage(named: itens[indexPath.row].getImageLink())
        cell.lblScore.text = String(itens[indexPath.row].getScore()) + " votes"
        
        
        cell.layer.cornerRadius = 8.0
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        cell.layer.masksToBounds = false

        
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row) selected")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


