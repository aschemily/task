//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Emily Asch on 2/9/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistentStorage()

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 75
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       tableView.reloadData()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}

        // Configure the cell...
        let task = TaskController.shared.tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //identify
        if segue.identifier == "cellToTaskDetailVC"{
            //index path
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            //destination
            guard let destination = segue.destination as? TaskDetailViewController else {return}
            
            //object to send
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            
            //object to receive
            destination.task = taskToSend
        }
        
    }
    

}

extension TaskListTableViewController: TaskCompletionDelegate{
    func taskCellButtonTapped(for cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let task = TaskController.shared.tasks[indexPath.row]
        
        TaskController.shared.toggleIsComplete(task: task)
        cell.updateViews()
    }
    
    
}
