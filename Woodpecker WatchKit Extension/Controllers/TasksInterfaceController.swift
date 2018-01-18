//
//  TasksInterfaceController.swift
//  Woodpecker WatchKit Extension
//
//  Created by IJke Botman on 18/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import WatchKit
import Foundation

class TasksInterfaceController: WKInterfaceController {
    @IBOutlet var addTaskButton: WKInterfaceButton!
    @IBOutlet var ongoingTable: WKInterfaceTable!
    
    @IBOutlet var completedLabel: WKInterfaceLabel!
    @IBOutlet var completedTable: WKInterfaceTable!
    
    var tasks: TaskList = TaskList()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadSavedTasks()
        
        loadOngoingTasks()
        loadCompletedTasks()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateOngoingTasksIfNeeded()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func onNewTask() {
        presentController(withName: NewTaskInterfaceController.ControllerName, context: tasks)
    }
}

// MARK: Table Interaction
extension TasksInterfaceController {
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        guard table === ongoingTable else { return }
        
        let task = tasks.ongoingTasks[rowIndex]
        tasks.didTask(task)
        if (task.isCompleted) {
            loadOngoingTasks()
            loadCompletedTasks()
        }
        else {
            let row = ongoingTable.rowController(at: rowIndex) as! OngoingTaskRowController
            row.updateProgress(with:task, frameWidth:contentFrame.size.width)
        }
        saveTasks()
    }
}

// MARK: Populate Tables
extension TasksInterfaceController {
    func loadOngoingTasks() {
        ongoingTable.setNumberOfRows(tasks.ongoingTasks.count, withRowType: OngoingTaskRowController.RowType)
        for i in 0..<ongoingTable.numberOfRows {
            let row = ongoingTable.rowController(at: i) as! OngoingTaskRowController
            let task = tasks.ongoingTasks[i]
            row.populate(with:task, frameWidth:contentFrame.size.width)
        }
        
        updateAddTaskButton()
    }
    
    func updateOngoingTasksIfNeeded() {
        if ongoingTable.numberOfRows < tasks.ongoingTasks.count {
            loadOngoingTasks()
            
            saveTasks()
            updateAddTaskButton()
        }
    }
    
    func loadCompletedTasks() {
        completedTable.setNumberOfRows(tasks.completedTasks.count, withRowType: CompletedTaskRowController.RowType)
        for i in 0..<completedTable.numberOfRows {
            let row = completedTable.rowController(at: i) as! CompletedTaskRowController
            let task = tasks.completedTasks[i]
            row.populate(with:task)
        }
        
        updateCompletedLabel()
    }
    
    func updateCompletedLabel() {
        completedLabel.setHidden(completedTable.numberOfRows == 0)
    }
    
    func updateAddTaskButton() {
        addTaskButton.setHidden(ongoingTable.numberOfRows != 0)
    }
}

// MARK: Task Persistance
extension TasksInterfaceController {
    private var savedTasksPath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docPath = paths.first!
        return (docPath as NSString).appendingPathComponent("SavedTasks")
    }
    
    func loadSavedTasks() {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: savedTasksPath)) {
            let savedTasks = NSKeyedUnarchiver.unarchiveObject(with: data) as! TaskList
            tasks = savedTasks
        } else {
            tasks = TaskList()
        }
    }
    
    func saveTasks() {
        NSKeyedArchiver.archiveRootObject(tasks, toFile: savedTasksPath)
    }
}
