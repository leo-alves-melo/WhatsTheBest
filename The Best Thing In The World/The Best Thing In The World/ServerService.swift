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
    private var user:User? = nil
    
    func getRandomItem(_ numberItens:Int) -> [Item]? {
        
        var itemsList:[Item] = []
        
        //Read File path
        if let filepath = Bundle.main.path(forResource: "DB", ofType: nil) {
            
            do {
                
                let contents = try String(contentsOfFile: filepath)
                
                let data = contents.data(using: .utf8)
                
                
                
                if let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]] {
                    
                    if(numberItens < parsedData.count) {
                        for json in 0..<numberItens {
                            
                            print("parsedData:\(parsedData[json])")
                            
                            itemsList.append(Item(text: parsedData[json]["subtitle"] as! String, image: parsedData[json]["imageLink"] as! String))
                            
                            
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
    
    func getRanking(type:RankingType) -> [Item]? {
        switch type {
        case .allTime:
            print("all time")
        case .lastMonth:
            print("last month")
        case .lastWeek:
            print("last week")
        case .today:
            print("today")
            
        }
        return nil
    }
    
    func uploadNewItemToServer(item:Item?) -> Bool {
        return false
    }
    
    func voteInAnItem(_ item:Item) -> Bool {
        return false
    }
}

