//
//  ServerService.swift
//  The Best Thing In The World
//
//  Created by Leonardo Alves de Melo on 3/30/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation

class ServerService {
    
    static let sharedInstance:ServerService = ServerService()
    
    private let urlServer = "http://www.meuserver.com/"
    private var user:User? = User(id: 1, name: "teste", gender: "F", age: 11, profile: "normal", score: 90)
    
    public var allItemsList:[Item] = []
    
    private init() {
        
        if let list = getAllItems() {
             allItemsList = list
            
        }
       
    }
    
   
    private func readItemInServer(_ numberItems:Int, _ source:String) -> String? {
        return Bundle.main.path(forResource: source, ofType: nil)
    }
    
    private func writeToFile(_ itemList:[Item]) -> Bool {
        
        var jsonList:[[String:Any]] = []
        
        for item in itemList {
            jsonList.append(createJsonFromItem(item))
        }
        
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent("DB")
            
            do {
                
                var text = "[\n"
                
                try text.write(to: path, atomically: false, encoding: .utf8)
                
               
                
                for json in jsonList {
                    let str = json.description
                    
                    try str.write(to: path, atomically: false, encoding: .utf8)

                    
                   
                    //try file.write(toFile: ",\n", atomically: false, encoding: .utf8)
                    
                }
                
                //try file.write(toFile: "\n]", atomically: false, encoding: .utf8)
            }
            catch {
                print("Erro ao escrever no arquivo!")
            }
        }
        else {
            print("Nao abri arquivo")
        }
        
        
        
        return false
    }
    
    private func sendToServer(_ json:[String:Any]) -> Bool {
        
        if var itemList = getAllItems() {
            //Look for the specific json and update it
            
            for item in itemList {
                if(item.id == json["ID"] as! Int) {
                    
                    item.setScore(json["score"] as! Int)
                    
                    return writeToFile(itemList)
                }
            }
            
            print("Item de id \(json["ID"] as! Int)")
        }
        
        
        
        return false
    }
    
    private func getUserByID(_ ID:Int) -> User {
        
        if let filepath = Bundle.main.path(forResource: "users", ofType: nil) {
            do {
                
                let contents = try String(contentsOfFile: filepath)
                
                let data = contents.data(using: .utf8)
                
                
                
                if let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]] {
                    
                    
                    for json in parsedData {
                        
                        
                        
                        let userID = json["ID"] as! Int
                        
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
    
    private func createJsonFromItem(_ item:Item) -> [String: Any] {
        return [
            "ID":item.id, "subtitle":item.subtitle, "user":item.owner.getId(user: item.owner), "score":item.score, "date":item.date, "imageLink": item.getImageLink()
            
            
        ]
    }
    
    public func updateItemInServer(_ item:Item) -> Bool {
        
        var returnValue = false
        
        for currentItem in allItemsList {
            if(currentItem.id == item.id) {
                currentItem.setScore(item.score)
                returnValue = true
            }
        }
        
        return returnValue
        
    }
    
    func getRandomItem(_ numberItens:Int) -> [Item]? {
        
        var itemsList:[Item] = []
        var indexList:[Int] = []
        
        for i in 0..<allItemsList.count {
            indexList.append(i)
        }
        
        
        for _ in 0..<numberItens {
            itemsList.append(allItemsList[indexList.remove(at: Int(arc4random_uniform(UInt32(indexList.count))))])
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
        
        var itemList:[Item] = []
        
        sortListItems(&allItemsList)
        
        
        switch type {
        case RankingType.allTime.rawValue:
 
            itemList = allItemsList
            
        case RankingType.lastMonth.rawValue:

            let lastMonthDate = Date(timeIntervalSinceNow: -604800*4)
            
            for item in allItemsList {
                
                let dateString = item.date
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "dd/MM/yyyy"
                let dateObj = dateFormater.date(from: dateString)
                
                
                if(dateObj! > lastMonthDate) {
                    itemList.append(item)
                }
                else {
                    print("maior")
                }
            }
            
                
        case RankingType.lastWeek.rawValue:
            
            let lastWeekDate = Date(timeIntervalSinceNow: -604800)
            
            for item in allItemsList {

                let dateString = item.date
                print(dateString)
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "dd/MM/yyyy"
                let dateObj = dateFormater.date(from: dateString)

            
                if(dateObj! > lastWeekDate) {
                    itemList.append(item)
                }
            }

            
        case RankingType.today.rawValue:
            let todayDate = Date(timeIntervalSinceNow: -86400)
            
            for item in allItemsList {
                
                let dateString = item.date
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "dd/MM/yyyy"
                let dateObj = dateFormater.date(from: dateString)
                
                
                if(dateObj! > todayDate) {
                    itemList.append(item)
                }
            }
            
                
        default:
            break
            
        }
        
        return itemList
    }
    
    func uploadNewItemToServer(item:Item?) -> Bool {
        
        var returnValue = false
        
        if let newItem = item {
            allItemsList.append(newItem)
            returnValue = true
        }
        
        return returnValue
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


