//
//  ProfileTableViewCell.swift
//  swiftyCompanion
//
//  Created by Florent VIOLIN on 1/26/18.
//  Copyright © 2018 Florent VIOLIN. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var infos : (String, String, String, String, String, String, String, String)? {
        didSet {
            if let info = infos {
                name?.text = info.0
                email?.text = "• " + info.1
                location?.text = "• " + info.3
                phone?.text = "• " + info.4
                login?.text = info.5
                level?.text = info.6
                grade?.text = info.7
                
                let value = Double(info.6)

                progressView.progress = Float((value?.truncatingRemainder(dividingBy: 1))!)
                progressView.tintColor = UIColor(red: 0.3373, green: 0.7765, blue: 0, alpha: 1)
                progressView.layer.cornerRadius = 8
                progressView.clipsToBounds = true
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
