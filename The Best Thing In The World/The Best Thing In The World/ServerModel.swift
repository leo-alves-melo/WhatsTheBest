//
//  ServerModel.swift
//  The Best Thing In The World
//
//  Created by Leonardo Alves de Melo on 3/30/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation

enum RankingType:Int {
    case allTime = 0
    case lastMonth = 1
    case lastWeek = 2
    case today = 3
}

enum RequestType:String {
    case updateItem = "updateItem"
    case uploadItem = "uploadItem"
    case getItem = "getItem"
    
}
