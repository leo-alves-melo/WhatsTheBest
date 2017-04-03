//
//  Item.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation

class Item {
    
    public private(set) var id:Int
    public private(set) var imageLink:String?
    public private(set) var subtitle:String?
    public private(set) var text:String?
    public private(set) var score:Int
    public private(set) var owner:User?
   

    
    public init() {
        owner = User()
        score = Int()
        id = Int()
    }
    
    public init(id: Int, subtitle: String, imageLink: String, score: Int, owner: User) {
        self.id = id
        self.subtitle = subtitle
        self.imageLink = imageLink
        self.score = score
        self.owner = owner
    }
    
    public init(id: Int, text: String, score: Int, owner: User) {
        self.id = id
        self.text = text
        self.score = score
        self.owner = owner
    }
    
    func getImageLink() -> String {
        
        return self.imageLink!
    }
    
    
    func increaseQtdVotes() {
        
        self.score += 1
    }
    
    
    
    

    
    
}
