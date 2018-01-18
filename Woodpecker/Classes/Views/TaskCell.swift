//
//  TaskCell.swift
//  Woodpecker
//
//  Created by IJke Botman on 18/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    static let ReuseId = "TaskCell"
    
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

// MARK: Populate Cell
extension TaskCell {
    func updateWithTask(_ task:Task) {
        nameLabel.text = task.name
        progressView.update(task.color.color, current: task.timesCompleted, total: task.totalTimes)
    }
}
