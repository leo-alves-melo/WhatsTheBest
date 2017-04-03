//
//  User.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation



class User {
    
    private var id: Int
    private var name:String
    private var gender:String
    private var age:Int
    private var profile:String
    private var qtdPoints:Int
    
    
    init()
    {
        name = String()
        gender = String()
        age = Int()
        profile = String()
        qtdPoints = 0
        id = 0
    }
    
    func getId (user : User) -> Int
    {
        
        return self.id
    }
}

