//
//  Node.swift
//  Tree
//
//  Created by Krasa on 11/04/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class Node<T> where T: Comparable {
    var left: Node?
    var right: Node?
    weak var parent: Node?
    
    let data: T
    
    init(data: T) {
        self.data = data
    }
}
