//
//  Item.swift
//  WhatsTheBest
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Leonardo Alves de Melo. All rights reserved.
//

import Foundation

class Item {
    
    var iDImage:String?
    var text:String?
    var owner:User
    var qtdVotes:Int
    
    
    init() {
        
        owner = User()
        qtdVotes = 0
    }
    
    
}
