//
//  TableViewController.swift
//  ToDoApp
//
//  Created by N!kS on 21.04.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var task: Task!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func addTaskButton(_ sender: Any) {
        let alert = UIAlertController(title: "New task",
                                      message: "Enter task",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Add",
                                      style: .default,
                                      handler: { _ in
                                        if let field = alert.textFields?.first{
                                            if let text = field.text,
                                               !text.isEmpty {
                                                self.task.add(composite: Task(name: text))
                                                self.tableView.reloadData()
                                            }
                                            
                                        }
                                        
                                      }))
        present(alert, animated: true)
        alert.addTextField { field in
            field.placeholder = "Enter task name"
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        if let parent = task.parent {
            task = parent as? Task
            checkBackButton()
            tableView.reloadData()
        }
    }
        
    private func checkBackButton() {
        if task.parent != nil {
            backButton.isEnabled = true
        } else {
            backButton.isEnabled = false
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        task = Task(name: "default")
        checkBackButton()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.children.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
        cell.textLabel?.text = task.children[indexPath.row].name
        let subtask = task.children[indexPath.row].children.count
        if subtask > 0 {
            cell.detailTextLabel?.text = "Subtasks: \(subtask)"
        } else {
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        task = task.children[indexPath.row] as? Task
        checkBackButton()
        tableView.reloadData()
    }
}
