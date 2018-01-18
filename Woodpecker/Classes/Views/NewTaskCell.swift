//
//  NewTaskCell.swift
//  Woodpecker
//
//  Created by IJke Botman on 18/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import UIKit

class NewTaskCell: UITableViewCell {
    
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskTimesField: UITextField!
    
    @IBOutlet var colorButtons: [UIButton]!
    
    var selectedColor: Task.Color!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for (i, button) in colorButtons.enumerated() {
            guard let color = Task.Color(rawValue: i)?.color else { continue }
            button.backgroundColor = color
        }
        reset()
    }
    
    func reset() {
        selectedColor = Task.Color.blue
        topContainer.backgroundColor = selectedColor.color
        
        taskNameField.text = nil
        taskTimesField.text = nil
    }
    
    @IBAction func onColorButton(_ sender: UIButton) {
        guard let index = colorButtons.index(of: sender) else { return }
        guard let color = Task.Color(rawValue: index) else { return }
        
        selectedColor = color
        
        topContainer.backgroundColor = selectedColor.color
    }
}
