//
//  TaskList.swift
//  Woodpecker
//
//  Created by IJke Botman on 18/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import UIKit

// NSObject Inheritance required for NSCoding
final public class TaskList: NSObject {
    
    public var ongoingTasks: [Task]
    public var completedTasks: [Task]
    
    public init(ongoing: [Task] = [], completed: [Task] = []) {
        self.ongoingTasks = ongoing
        self.completedTasks = completed
    }
}

// MARK: Methods
extension TaskList {
    public func addTaskToFront(_ task: Task) {
        guard !task.isCompleted else { return }
        ongoingTasks.insert(task, at: 0)
    }
    
    public func addTask(_ task: Task) {
        if (task.isCompleted) {
            completedTasks.append(task)
        }
        else {
            ongoingTasks.append(task)
        }
    }
    
    public func didTask(_ task:Task) {
        if task.isCompleted {
            return
        }
        task.completeOnce()
        if task.isCompleted {
            finishedTask(task)
        }
    }
    
    public func finishedTask(_ task: Task) {
        if let index = ongoingTasks.index(of: task) {
            ongoingTasks.remove(at: index)
            completedTasks.append(task)
        }
    }
}

// MARK: NSCoding
extension TaskList: NSCoding {
    private struct CodingKeys {
        static let ongoing = "ongoing"
        static let completed = "completed"
    }
    
    public convenience init(coder aDecoder: NSCoder) {
        let ongoing = aDecoder.decodeObject(forKey: CodingKeys.ongoing) as! [Task]
        let completed = aDecoder.decodeObject(forKey: CodingKeys.completed) as! [Task]
        
        self.init(ongoing: ongoing, completed: completed)
    }
    
    public func encode(with encoder: NSCoder) {
        encoder.encode(ongoingTasks, forKey: CodingKeys.ongoing)
        encoder.encode(completedTasks, forKey: CodingKeys.completed)
    }
    
}
