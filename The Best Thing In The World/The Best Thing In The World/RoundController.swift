//
//  RoundController.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation


class RoundController {


    private var serverService = ServerService.sharedInstance

    private var queueItem = Queue<Item>()
    

    func getItemsFromServer() {
        
        if let items = serverService.getRandomItem(8) {
            
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
            return Item(id: 0, subtitle: "empty", imageLink: "empty", score: 0, owner: User(), date: "19/09/2013")
        }
    }
    
    func increaseVoteItem (_ item:Item)
    {
        serverService.voteInAnItem(item)
    }
    
    func loadSentence(itemName: String, mod:Int) -> String
    {
        var s:String = ""
        if mod < 0 { //sentences de um item especifico
            
            let diceRoll = Int(arc4random_uniform(UInt32(100))) //Chance de falar algo relevante ou aleatorio
            
            if diceRoll > 10 { //Fale algo relevante
                if let sentence = SentenceModel.itemSentences[itemName] {
                    s = sentence
                }
                else { //Item nao encontrado, fale qualquer coisa
                    print("Item nao encontrado: \(itemName)")
                    let indexRandom = Int(arc4random_uniform(UInt32(SentenceModel.banterSentences.count)))
                    s = SentenceModel.banterSentences[indexRandom]
                }
            }
            else { //Fale algo aleatorio
                let indexRandom = Int(arc4random_uniform(UInt32(SentenceModel.banterSentences.count)))
                s = SentenceModel.banterSentences[indexRandom]
            }
        }
        else {
            s = SentenceModel.systemSentences[mod]
        }
        return s
    }
}
