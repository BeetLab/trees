//
//  AVLNode.swift
//  Tree
//
//  Created by Krasa on 12/04/2019.
//  Copyright © 2019 Nikita Semenov. All rights reserved.
//

import Foundation

class AVLNode<T: Comparable>: Node<T> {
    var height = 0
    var balanceFactor: Int {
        let lh = leftAvlChild?.height ?? -1
        let rh = rightAvlChild?.height ?? -1
        return rh - lh
    }
    
    var leftAvlChild: AVLNode<T>? {
        get {
            return left as? AVLNode<T>
        }
        
        set {
            left = newValue
        }
    }
    var rightAvlChild: AVLNode<T>? {
        get {
            return right as? AVLNode<T>
        }
        
        set {
            right = newValue
        }
    }
    var parentAvlNode: AVLNode<T>? {
        return parent as? AVLNode<T>
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return rightAvlChild == nil && leftAvlChild == nil
    }
    
    var isLeftChild: Bool {
        return parentAvlNode?.left === self
    }
    
    var isRightChild: Bool {
        return parentAvlNode?.right === self
    }
    
    var hasLeftChild: Bool {
        return leftAvlChild != nil
    }
    
    var hasRightChild: Bool {
        return rightAvlChild != nil
    }
    
    var hasAnyChild: Bool {
        return leftAvlChild != nil || rightAvlChild != nil
    }
    
    var hasBothChildren: Bool {
        return leftAvlChild != nil && rightAvlChild != nil
    }
}
