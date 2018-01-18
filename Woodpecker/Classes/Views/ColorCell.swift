//
//  ColorCell.swift
//  Woodpecker
//
//  Created by IJke Botman on 18/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    static let ReuseId = "ColorCell"
    @IBOutlet weak var selectionView: UIView!
    
    override func awakeFromNib() {
        selectionView.layer.borderColor = UIColor.white.cgColor
        selectionView.layer.borderWidth = 4
    }
    
    func setColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    override var isSelected: Bool {
        didSet {
            selectionView.isHidden = !isSelected
        }
    }
}
