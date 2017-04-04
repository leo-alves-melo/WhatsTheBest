//
//  RoundController.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation


class RoundController {


    private var serverService = ServerService()

    private var queueItem = Queue<Item>()

    func getItemsFromServer() {
        
        if let items = serverService.getRandomItem(2) {
            
            //let item = Item(id: 1234, text: "batata", score: 10, owner: User(), date: "batata")
            for item in items {
                self.queueItem.enqueue(item)
            }
        }
    }
    
    func changeItem () -> Item
    {
        if queueItem.isEmpty {
            getItemsFromServer()
        }
        
        if let item:Item = self.queueItem.dequeue() {
            return item
        }
        else {
            var item = Item(id: 0, text: "empty", score: 0, owner: User(), date: "empty")
            return item
        }
    }
    
    func increaseVoteItem (_ item:Item)
    {
        
        serverService.voteInAnItem(item)
       
        //acessar servidor e incrementar qtd de votos do item recebido.
        
    }
    
    
    

}
