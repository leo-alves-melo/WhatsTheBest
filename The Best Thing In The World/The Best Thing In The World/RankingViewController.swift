//
//  RankingViewController.swift
//  The Best Thing In The World
//
//  Created by Jessica Batista de Barros Cherque on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellRanking", for: indexPath) as! RankingTableViewCell
        
        cell.imageThing.image = UIImage(named: "star")
        cell.thingName.text = "Star"
        cell.userName.text = "Anakin"
        cell.points.text = "1234 points"
        
        return cell
    }
    
}
