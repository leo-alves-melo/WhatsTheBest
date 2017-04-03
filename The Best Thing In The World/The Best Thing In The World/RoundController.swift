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
            for i in 0...items.count-1 {
                self.queueItem.enqueue(items[i])
            }
        }
    }
    
    func changeItem () -> Item
    {
        if let item:Item = self.queueItem.dequeue() {
            return item
        }
        else {
            var item = Item(subtitle: "empty", imageLink: "empty", score: 0)
            return item
        }
    }
    
    func increaseVoteItem (_ item:Item)
    {
        
        serverService.voteInAnItem(item)
       
        //acessar servidor e incrementar qtd de votos do item recebido.
        
    }
    
    
    

}
