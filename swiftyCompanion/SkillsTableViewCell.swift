//
//  SkillsTableViewCell.swift
//  swiftyCompanion
//
//  Created by Florent VIOLIN on 1/26/18.
//  Copyright © 2018 Florent VIOLIN. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    var user_skills : [(String, String)]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var skillCellView: UITableView! {
        didSet {
            skillCellView.delegate = self
            skillCellView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let skills = user_skills {
            return skills.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as! SubSkillViewCell
        cell.skill = user_skills?[indexPath.row]
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
