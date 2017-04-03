//
//  Item.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation

class Item {
    
    private var idImage:String?
    private var text:String?
    private var owner:User
    private var qtdVotes:Int
    
    public init() {
        owner = User()
        qtdVotes = 0
    }
    
    public init(text: String, image: String) {
        self.text = text
        self.idImage = image
        owner = User()
        qtdVotes = 0
    }
    
    func getIdImage() -> String {
        return self.idImage!
    }
    
    func getText() -> String {
        return self.text!
    }
    
    func getOwner() -> User {
        return self.owner
    }
    
    func getQtdVotes() -> Int {
        return self.qtdVotes
    }
    
    func increaseQtdVotes() {
        self.qtdVotes += 1
    }

    
    
}
