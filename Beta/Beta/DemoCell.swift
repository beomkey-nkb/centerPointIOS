//
//  DemoCell.swift
//  Beta
//
//  Created by 남기범 on 2017. 11. 12..
//  Copyright © 2017년 고정민. All rights reserved.
//

import UIKit
import FoldingCell

class DemoCell: FoldingCell {
    
    @IBOutlet weak var closeNumberLabel: UILabel!
    @IBOutlet weak var openNumberLabel: UILabel!
    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = String(number)
            openNumberLabel.text = String(number)
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 5
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
