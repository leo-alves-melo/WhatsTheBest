//
//  Queue.swift
//  The Best Thing In The World
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 30/03/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation



public struct Queue<T> {
    
    
    fileprivate var list = LinkedList<T>()
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
    
    public mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    
    public mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else { return nil }
        
        list.remove(element)
        
        return element.value
    }
    
    
    public func peek() -> T? {
        return list.first?.value
    }
}


extension Queue: CustomStringConvertible {
    
    public var description: String {
        
        return list.description
    }
}

