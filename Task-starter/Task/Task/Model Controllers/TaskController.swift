//
//  TaskController.swift
//  Task
//
//  Created by Emily Asch on 2/10/22.
//

import Foundation

class TaskController {
    
   static let shared = TaskController()
    
    var tasks:[Task] = []
    
    //MARK: CRUD
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?){
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistentStorage()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?){
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistentStorage()
    }
    
    func toggleIsComplete(task: Task){
        task.isComplete = !task.isComplete
    }
    
    func delete(task: Task){
        //equatable 
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        saveToPersistentStorage()
    }
    
    //MARK: Persistence methods
    
    func fileURL() -> URL{
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Task.json")
     //   print("🤞doucment directory url", documentsDirectoryURL)
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage(){
        do{
            let data = try JSONEncoder().encode(tasks)
            try data.write(to:fileURL())
        }catch{
            print("✅save to persistent error is:", error)
        }
    }
    
    func loadFromPersistentStorage(){
        do{
            let data = try Data(contentsOf: fileURL())
            tasks = try JSONDecoder().decode([Task].self, from: data)
            
        }catch{
            print("🔥load from persistent storage error", error)
            print(error.localizedDescription)
        }
    }
    
    
    
    
}//End of class
