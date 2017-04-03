//
//  ServerService.swift
//  The Best Thing In The World
//
//  Created by Leonardo Alves de Melo on 3/30/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation

class ServerService {
    
    private let urlServer = "http://www.meuserver.com/"
    private var user:User? = User(id: 1, name: "teste", gender: "F", age: 11, profile: "normal")
    
    private func readItemInServer(_ numberItems:Int, _ source:String) -> String? {
        return Bundle.main.path(forResource: source, ofType: nil)
    }
    
    private func sendToServer(_ json:[String:Any]) -> Bool {
        
        return false
    }
    
    private func getUserByID(_ ID:Int) -> User {
        
        if let filepath = Bundle.main.path(forResource: "users", ofType: nil) {
            do {
                
                let contents = try String(contentsOfFile: filepath)
                
                let data = contents.data(using: .utf8)
                
                
                
                if let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]] {
                    
                    
                    for json in parsedData {
                        
                        
                        
                        let userID = json["id"] as! Int
                        
                        //If we find the user, create an object and return it
                        if(userID == ID) {
                            
                            let name = json["name"] as! String
                            let gender = json["gender"] as! String
                            let age = json["age"] as! Int
                            let score = json["score"] as! Int
                            
                            return User(id: userID, name: name, gender: gender, age: age, profile: "\(score)")
                            
                           
                        }
                    }
                    
                    print("Usuário de ID \(ID) não encontrado!")
                    
                    
                }
            }
            catch {
                print("Não encontrei arquivo de usuarios")
            }
            
        }
        
        return User()
    }
    
    public func updateItemInServer(_ item:Item) -> Bool {
        
        let json:[String:Any] =
        [
            "ID":9, "subtitle":"a", "user":1, "score":1, "date":"a", "imageLink": item.getImageLink()
                
            
        ]
        
        return sendToServer(json)
        
    }
    
    func getRandomItem(_ numberItens:Int) -> [Item]? {
        
        var itemsList:[Item] = []
        
        //Read File path
        if let filepath = readItemInServer(numberItens, "DB") {
            
            do {
                
                let contents = try String(contentsOfFile: filepath)
                
                let data = contents.data(using: .utf8)
                
                
                
                if let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]] {
                    
                    if(numberItens <= parsedData.count) {
                        for json in 0..<numberItens {
                            
                            let id = parsedData[json]["ID"] as! Int
                            let subtitle = parsedData[json]["subtitle"] as! String
                            let userID = parsedData[json]["user"] as! Int
                            let score = parsedData[json]["score"] as! Int
                            let date = parsedData[json]["date"] as! String
                            let imageLink = parsedData[json]["imageLink"] as! String
                            
                            var user = getUserByID(userID)
                            
                            
                            itemsList.append(Item(id: id, subtitle: subtitle, score: score, owner: user, date:imageLink))
                            
                          
                            
                            
                        }
                    }
                    else {
                        print("A lista contém apenas \(parsedData.count) elementos, mas você pediu \(numberItens)")
                    }
                    
                    
                    
                    
                }
                
               
            }
            catch {
                print("catch")
            }
            
        }
        else {
            
            print("else")
            
        }
        return itemsList
    }
    
    private func getAllItems() -> [Item]? {
        
        var itemsList:[Item] = []
        
        //Read File path
        if let filepath = readItemInServer(10, "DB") {
            
            do {
                
                let contents = try String(contentsOfFile: filepath)
                
                let data = contents.data(using: .utf8)
                
                
                
                if let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]] {
                    
                
                    for json in parsedData {
                        
                        let id = json["ID"] as! Int
                        let subtitle = json["subtitle"] as! String
                        let userID = json["user"] as! Int
                        let score = json["score"] as! Int
                        let date = json["date"] as! String
                        let imageLink = json["imageLink"] as! String
                        
                        var user = getUserByID(userID)
                        
                        
                        itemsList.append(Item(id: id, subtitle: subtitle, imageLink:imageLink, score: score, owner: user))
                        
                        itemsList.append(Item(id: parsedData[json]["ID"] as! Int, subtitle: parsedData[json]["subtitle"] as! String, imageLink: parsedData[json]["imageLink"] as! String, score: parsedData[json]["score"] as! Int, owner: self.user!, date: parsedData[json]["date"] as! String))
                        
                        
                    }
                }
        
        
    }
    
    func getRanking(type:Int) -> [Item]? {
        switch type {
        case RankingType.allTime.rawValue:
            print("all time")
        case RankingType.lastMonth.rawValue:
            print("last month")
        case RankingType.lastWeek.rawValue:
            print("last week")
        case RankingType.today.rawValue:
            print("today")
        default:
            break
            
        }
        return nil
    }
    
    func uploadNewItemToServer(item:Item?) -> Bool {
        return false
    }
    
    func voteInAnItem(_ item:Item) -> Bool {
        
        item.increaseQtdVotes()
        
        
        
        return false
    }
}

