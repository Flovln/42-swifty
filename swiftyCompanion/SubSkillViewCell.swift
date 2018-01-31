//
//  SubSkillViewCell.swift
//  swiftyCompanion
//
//  Created by Florent VIOLIN on 1/26/18.
//  Copyright © 2018 Florent VIOLIN. All rights reserved.
//

import UIKit

class SubSkillViewCell: UITableViewCell {

    @IBOutlet weak var skillLevel: UILabel!
    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var skill: (String, String)? {
        didSet {
            if let s = skill {
                skillName?.text = s.0
                let value = Double(s.1)!
                skillLevel?.text = String(value)

                /* Progress bar */
                progressView.progress = Float(value.truncatingRemainder(dividingBy: 1))
                progressView.tintColor = UIColor.green
                progressView.layer.cornerRadius = 3
                progressView.clipsToBounds = true
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
