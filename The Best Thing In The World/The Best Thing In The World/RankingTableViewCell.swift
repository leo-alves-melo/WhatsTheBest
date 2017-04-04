//
//  RankingTableViewCell.swift
//  The Best Thing In The World
//
//  Created by Jessica Batista de Barros Cherque on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    
    @IBOutlet var imageThing: UIImageView!
    @IBOutlet var thingName: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
