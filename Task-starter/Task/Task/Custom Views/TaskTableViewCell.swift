//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Emily Asch on 2/10/22.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject{
    func taskCellButtonTapped(for cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    weak var delegate: TaskCompletionDelegate?
   
    var task: Task?{
        didSet{
            self.updateViews()
        }
    }
    
    func updateViews(){
        print("👽update view task table view cell")
        guard let task = task else {return print("❌no task?")}
        taskNameLabel.text = task.name
        
        if task.isComplete == true{
            
            completeButton.setBackgroundImage(UIImage(named: "complete"), for: UIControl.State.normal)
        }else{
            completeButton.setBackgroundImage(UIImage(named: "incomplete"), for: UIControl.State.normal)
        }
    }
    
    
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(for: self)
    }
    
    
}
