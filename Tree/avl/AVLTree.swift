//
//  AVLTree.swift
//  Tree
//
//  Created by Krasa on 12/04/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class AVLTree<T: Comparable & CustomStringConvertible>: BinaryTree<T> {
    private var avlRoot: AVLNode<T>? {
        get {
            return root as? AVLNode<T>
        }
        set {
            guard let newValue = newValue else { return }
            root = newValue
        }
    }
    
    @discardableResult
    override func add(node: Node<T>) -> Bool {
        if super.add(node: node) {
            guard let avlNode = node as? AVLNode<T> else { return true }
            balance(node: avlNode)
            return true
        } else {
            return false
        }
    }
    
    override var description: String {
        guard let rootAVLNode = root as? AVLNode<T> else { return super.description }
        let closure = { (node: AVLNode<T>) -> (String, AVLNode<T>?, AVLNode<T>?) in
            return (node.data.description + "(\(node.balanceFactor))", node.left as? AVLNode, node.right as? AVLNode)
        }
        return treeString(rootAVLNode, using: closure)
    }
}


extension AVLTree {
    private func assignHight(node: AVLNode<T>?) {
        guard let node = node else { return }
        let leftChildHeight = node.leftAvlChild?.height ?? -1
        let rightChildHeight = node.rightAvlChild?.height ?? -1
        node.height = max(leftChildHeight, rightChildHeight) + 1
        assignHight(node: node.parentAvlNode)
    }
    
    private func balance(node: AVLNode<T>?) {
        guard let node = node else { return }
        
        assignHight(node: node.leftAvlChild)
        assignHight(node: node.rightAvlChild)
        
        var nodes = [AVLNode<T>?](repeating: nil, count: 3)
        var subtrees = [AVLNode<T>?](repeating: nil, count: 4)
        let nodeParent = node.parentAvlNode
        
        let balanceFactor = node.balanceFactor
        
        if balanceFactor < -1 {
            // left-left or left-right
            if let leftChild = node.leftAvlChild {
                if leftChild.balanceFactor < 0 {
                    // left-left
                    nodes[0] = node
                    nodes[2] = node.leftAvlChild
                    nodes[1] = nodes[2]?.leftAvlChild

                    subtrees[0] = nodes[1]?.leftAvlChild
                    subtrees[1] = nodes[1]?.rightAvlChild
                    subtrees[2] = nodes[2]?.rightAvlChild
                    subtrees[3] = nodes[0]?.rightAvlChild
                } else {
                    // left-right
                    nodes[0] = node
                    nodes[1] = node.leftAvlChild
                    nodes[2] = nodes[1]?.rightAvlChild

                    subtrees[0] = nodes[1]?.leftAvlChild
                    subtrees[1] = nodes[2]?.leftAvlChild
                    subtrees[2] = nodes[2]?.rightAvlChild
                    subtrees[3] = nodes[0]?.rightAvlChild
                }
            }
        } else if balanceFactor > 1 {
            // right-left or right-right
            if let rightChild = node.rightAvlChild {
                if rightChild.balanceFactor > 0 {
                    // right-right
                    nodes[1] = node
                    nodes[2] = node.rightAvlChild
                    nodes[0] = nodes[2]?.rightAvlChild
                    
                    subtrees[0] = nodes[1]?.leftAvlChild
                    subtrees[1] = nodes[2]?.leftAvlChild
                    subtrees[2] = nodes[0]?.leftAvlChild
                    subtrees[3] = nodes[0]?.rightAvlChild
                } else {
                    // right-left
                    nodes[1] = node
                    nodes[0] = node.rightAvlChild
                    nodes[2] = nodes[0]?.leftAvlChild
                    
                    subtrees[0] = nodes[1]?.leftAvlChild
                    subtrees[1] = nodes[2]?.leftAvlChild
                    subtrees[2] = nodes[2]?.rightAvlChild
                    subtrees[3] = nodes[0]?.rightAvlChild
                }
            }
        } else {
            balance(node: node.parentAvlNode)
            return
        }
        
        // nodes[2] is always the head
        
        if node.isRoot {
            avlRoot = nodes[2]
            avlRoot?.parent = nil
        } else if node.isLeftChild {
            nodeParent?.leftAvlChild = nodes[2]
            nodes[2]?.parent = nodeParent
        } else if node.isRightChild {
            nodeParent?.rightAvlChild = nodes[2]
            nodes[2]?.parent = nodeParent
        }
        
        nodes[2]?.leftAvlChild = nodes[1]
        nodes[1]?.parent = nodes[2]
        nodes[2]?.rightAvlChild = nodes[0]
        nodes[0]?.parent = nodes[2]
        
        nodes[1]?.leftAvlChild = subtrees[0]
        subtrees[0]?.parent = nodes[1]
        nodes[1]?.rightAvlChild = subtrees[1]
        subtrees[1]?.parent = nodes[1]
        
        nodes[0]?.leftAvlChild = subtrees[2]
        subtrees[2]?.parent = nodes[0]
        nodes[0]?.rightAvlChild = subtrees[3]
        subtrees[3]?.parent = nodes[0]

        assignHight(node: nodes[1])
        assignHight(node: nodes[0])
        
        balance(node: nodes[2]?.parentAvlNode)
    }
}
