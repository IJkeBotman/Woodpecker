//
//  OngoingTaskRowController.swift
//  Woodpecker WatchKit Extension
//
//  Created by IJke Botman on 18/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import UIKit
import WatchKit

class OngoingTaskRowController: NSObject {
    static let RowType = "OngoingTaskRow"
    
    @IBOutlet var group: WKInterfaceGroup!
    
    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var progressLabel: WKInterfaceLabel!
    
    @IBOutlet var progressBackgroundGroup: WKInterfaceGroup!
    @IBOutlet var progressGroup: WKInterfaceGroup!
    
}

/** NOTES:
 Should be able to adjust progressGroup using RELATIVE WIDTH
 However, currently that only adjusts the width to 3 values, 0, 0.5, 1
 Thus, the frameWidth is needed as a workaround
 **/
extension OngoingTaskRowController {
    func populate(with task:Task, frameWidth:CGFloat) {
        nameLabel.setText(task.name)
        
        updateProgress(with:task, frameWidth:frameWidth)
    }
    
    func updateProgress(with task:Task, frameWidth:CGFloat) {
        progressLabel.setText("\(task.totalTimes - task.timesCompleted)")
        
        progressBackgroundGroup.setBackgroundColor(task.color.color.withAlphaComponent(0.15))
        progressGroup.setBackgroundColor(task.color.color)
        
        let progressLeft = 1.0 - CGFloat(task.timesCompleted) / CGFloat(task.totalTimes)
        
        progressGroup.setWidth(progressLeft * frameWidth)
    }
}
