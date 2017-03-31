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
        return nil
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
}

