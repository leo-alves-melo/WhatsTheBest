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
    
    
    init()
    {
        name = String()
        gender = String()
        age = Int()
        profile = String()
        id = Int()
    }
    
    init (id: Int, name: String, gender: String, age: Int, profile:String)
    {
        self.id = id
        self.name = name
        self.gender = gender
        self.age = age
        self.profile = profile
    
    }
    
    func getId (user : User) -> Int
    {
        
        return self.id
    }
}

