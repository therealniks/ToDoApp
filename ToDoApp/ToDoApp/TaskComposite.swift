//
//  TaskComposite.swift
//  ToDoApp
//
//  Created by N!kS on 21.04.2021.
//

import Foundation

protocol TaskComposite: AnyObject {
   
    var name: String { get }
    var parent: TaskComposite? { get set }
    var children: [TaskComposite] { get set }
    
    func add(composite: TaskComposite)
}

class Task: TaskComposite {
    var children = [TaskComposite]()    
    var parent: TaskComposite?
    var name: String
    
    func add(composite: TaskComposite) {
        composite.parent = self
        children.append(composite)
    }
    
    init(name: String) {
        self.name = name
    }
}
