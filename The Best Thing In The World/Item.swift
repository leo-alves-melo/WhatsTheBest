//
//  Item.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation

class Item {
    
    private var id:Int?
    private var imageLink:String?
    private var subtitle:String?
    private var text:String?
    private var score:Int
    private var owner:User?
   

    
    public init() {
        owner = User()
        score = 0
    }
    
    public init(subtitle: String, imageLink: String, score: Int) {
        self.subtitle = subtitle
        self.imageLink = imageLink
        self.score = score
    }
    
    public init(text: String, score: Int) {
        self.text = text
        self.score = score
    }
    
    func getImageLink() -> String {
        
        return self.imageLink!
    }
    
    
    func increaseQtdVotes() {
        
        self.score += 1
    }

    
    
}
