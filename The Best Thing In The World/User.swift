//
//  User.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation

class User {
    
    var name:String
    var gender:String
    var age:Int
    var profile:String
    var qtdPoints:Int
    
    init()
    {
        name = String()
        gender = String()
        age = Int()
        profile = String()
        qtdPoints = 0
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getQtdPoints() -> Int {
        return self.qtdPoints
    }
}

