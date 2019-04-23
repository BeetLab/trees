//
//  main.swift
//  Tree
//
//  Created by Krasa on 11/04/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

let bsRoot = Node(data: 5)
let avlRoot = AVLNode(data: 5)

let bsTree = BinaryTree(root: bsRoot)
let avlTree = AVLTree(root: avlRoot)

for i in 1...50 {
    let data = Int.random(in: 0...i)
    
    bsTree.add(node: Node(data: data))
    avlTree.add(node: AVLNode(data: data))
}

print("bst:\n\n")
print(bsTree)
print("\n\navl:\n\n")
print(avlTree)
