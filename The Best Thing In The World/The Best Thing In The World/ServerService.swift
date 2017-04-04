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
    private var user:User? = User(id: 1, name: "teste", gender: "F", age: 11, profile: "normal", score: 90)
    
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
                            
                            return User(id: userID, name: name, gender: gender, age: age, profile: "",score: score)
                            
                           
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
            "ID":item.id, "subtitle":item.subtitle, "user":item.owner.getId(user: item.owner), "score":item.score, "date":item.date, "imageLink": item.getImageLink()
                
            
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
                            
                            
                            itemsList.append(Item(id: id, subtitle: subtitle, imageLink: imageLink, score: score, owner: user, date: date))
                            
                          
                            
                            
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
    
    private func sortListItems(_ itemsList: inout [Item]) {
        
        //Solving using insertion sort
        
        for i in 0..<itemsList.count {
            var higher = i
            
            for j in i..<itemsList.count {
                if(itemsList[j].score > itemsList[higher].score) {
                    higher = j
                }
            }
            
            if(higher != i) {
                swap(&itemsList[higher], &itemsList[i])
            }
            
        }
        
        
        
        
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
                        
                        
                        itemsList.append(Item(id: id, subtitle: subtitle, imageLink: imageLink, score: score, owner: user, date: date))
                        
                        
                    }
                    
                    
                }
                
                
                
            } catch {
                print("Não encontrei arquivo de itens")
            }
        }
        
            
        
            return itemsList
        
    }
    
    func getRanking(type:Int) -> [Item]? {
        
        var itemsList:[Item] = []
        
        switch type {
        case RankingType.allTime.rawValue:
            
            if var allItemsList = getAllItems() {
                sortListItems(&allItemsList)
                itemsList = allItemsList
                
                
            }
            
        case RankingType.lastMonth.rawValue:
            if var allItemsList = getAllItems() {
                sortListItems(&allItemsList)
                itemsList = allItemsList
                
                
            }
        case RankingType.lastWeek.rawValue:
            if var allItemsList = getAllItems() {
                sortListItems(&allItemsList)
                itemsList = allItemsList
                
                
            }
        case RankingType.today.rawValue:
            if var allItemsList = getAllItems() {
                sortListItems(&allItemsList)
                itemsList = allItemsList
                
                
            }
        default:
            break
            
        }
        return itemsList
    }
    
    func uploadNewItemToServer(item:Item?) -> Bool {
        return false
    }
    
    func voteInAnItem(_ item:Item) -> Bool {
        
        item.increaseQtdVotes()
     
        if(!updateItemInServer(item)) {
            print("Não consegui atualizar este item no servidor!")
            return false
        }
        else {
            return true
        }
        
        
        
    }
}


