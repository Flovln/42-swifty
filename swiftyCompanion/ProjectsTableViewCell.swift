//
//  ProjectsTableViewCell.swift
//  swiftyCompanion
//
//  Created by Florent VIOLIN on 1/26/18.
//  Copyright © 2018 Florent VIOLIN. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var projectGrade: UILabel!
    @IBOutlet weak var projectTitle: UILabel!

    var project : (String, String, Bool)? {
        didSet {
            if let p = project {
                projectTitle?.text = p.0
                projectGrade?.text = p.1

                if (p.2 == false) {
                    projectGrade?.textColor = UIColor(red: 0.8078, green: 0.1686, blue: 0.2, alpha: 1)
                } else {
                    projectGrade?.textColor = UIColor(red: 0.3373, green: 0.7765, blue: 0, alpha: 1)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
