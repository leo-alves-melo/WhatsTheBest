//
//  RankingViewController.swift
//  The Best Thing In The World
//
//  Created by Jessica Batista de Barros Cherque on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, UITabBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    var listItems:[Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.selectedItem = self.tabBar.items![0]
        
        listItems = ServerService.sharedInstance.getRanking(type: RankingType.allTime.rawValue)!

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tag = tabBar.selectedItem!.tag
        listItems = ServerService.sharedInstance.getRanking(type: tag)!
        tableView.reloadData()

    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tag = tabBar.selectedItem!.tag
        listItems = ServerService.sharedInstance.getRanking(type: tag)!
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellRanking", for: indexPath) as! RankingTableViewCell
        
        cell.imageThing.image = UIImage(named: self.listItems[indexPath.row].getImageLink())
        cell.thingName.text = self.listItems[indexPath.row].getSubtitle()
        cell.userName.text = self.listItems[indexPath.row].getOwner().getName()
        cell.points.text = "\(self.listItems[indexPath.row].getScore()) points"
        
        return cell
    }
    
}
