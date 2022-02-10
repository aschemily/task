//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Emily Asch on 2/10/22.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskNameTextFieldLabel: UITextField!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    @IBOutlet weak var taskNotesTextView: UITextView!
    
    var date: Date?
    //landing pad
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews(){
        guard let task = task else {return}
        
        taskNameTextFieldLabel.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
        print(task.dueDate)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("🤞save button tapped")
      //  guard let task = task else {return}
        guard let taskName = taskNameTextFieldLabel.text, !taskName.isEmpty,
              let notes = taskNotesTextView.text else {return}
        
        if let task = task{
            print("updating task")
            TaskController.shared.update(task: task, name: taskName, notes: notes, dueDate: date)
            print(task.dueDate)
        }else{
            print("create new task")
            TaskController.shared.createTaskWith(name: taskName, notes: notes, dueDate: date)
        }
        //animated save button back
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
  

}
