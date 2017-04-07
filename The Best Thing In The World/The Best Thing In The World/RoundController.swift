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
            var item = Item(id: 0, subtitle: "empty", imageLink: "empty", score: 0, owner: User(), date: "19/09/2013")
            return item
        }
    }
    
    func increaseVoteItem (_ item:Item)
    {
        
        serverService.voteInAnItem(item)
        
    }
    
    func loadSentences() -> [String:String]
    {
        let sentences = ["batata": "Ah é batata né?",
                         "australia": "Passei minha lua de minha ali",
                         "santos": "Time favorito do meu avô",
                         "carro": "Bebe demais",
                         "camisaxadrez": "-",
                         "cabide": "Só me nota quando precisa de mim",
                         "cellphone": "Duvido voce viver sem",
                         "ger": "-",
                         "music": "-",
                         "lego": "Experimente pisar em mim.",
                         "starwars":"-",
                         "terra":"-",
                         "youtube":"-",
                         "pordosol": "-",
                         "trollface":"-",
                         "arcondicionado":"-",
                         "breakingbad": "Melhor serie",
                         "Patrick": "-",
                         "temaki": "-",
                         "pizza": "Yummy",
                         "crash":"-",
                         "deadpool":"-",
                         "ironmaiden":"-",
                         "beatles":"-",
                         "unicamp":"-",
                         "pastel":"-",
                         "guitarra":"-",
                         "copadomundo":"-",
                         "mario":"Tenta lembrar da musica do jogo",
                         "buzz": "Ao infinito e alem",
                         "pinkfloyd":"-",
                         "reddit": "-",
                         "piramide": "-",
                         "balada": "Porque as vezes o Netflix cansa",
                         "reciclagem":"-",
                         "lorojose":"-",
                         "facebird":"Meme mais famoso do FB",
                         "brocolis":"-",
                         "facebook": "Passa mais tempo comigo do que com sua mae",
                         "dolly": "Seu amiguinho",
                         "wify": "Motivo dos seus check-ins",
                         "apple": "-",
                         "monalisa":"-",
                         "robertocarlos": "Te encontro na virada",
                         "business":"-"
            
                         
            ]
        
        /*
        self.sentences.append("Esse nem eu escolheria.")
        self.sentences.append("Esse foi meu sonho de criança.")
        self.sentences.append("Dificil hein?")
        self.sentences.append("Nao deixe sua mulher ver isso!")
        self.sentences.append("HAHAHA Duvido que consiga escolher um")
 */
        
        return sentences
    }
    
    
    
}
