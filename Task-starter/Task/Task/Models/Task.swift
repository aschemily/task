//
//  Task.swift
//  Task
//
//  Created by Emily Asch on 2/10/22.
//

import Foundation
class Task: Codable{
    var name: String
    var notes: String?
    var dueDate: Date?
    var isComplete: Bool
    
    init(name: String, notes: String?, dueDate: Date?, isComplete: Bool = false){
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
    
    
}

extension Task: Equatable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.name == rhs.name {return true}
        if lhs.notes == rhs.notes {return true}
        if lhs.dueDate == rhs.dueDate {return true}
        if lhs.isComplete == rhs.isComplete {return true}
        
        return false
    }
    
    
}
