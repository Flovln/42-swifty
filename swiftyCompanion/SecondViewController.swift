//
//  SecondViewController.swift
//  swiftyCompanion
//
//  Created by florent violin on 25/01/2018.
//  Copyright © 2018 Florent VIOLIN. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user_infos : [(String, String, String, String, String, String, String, String)]?
    var user_skills : [(String, String)]?
    var user_projects : [(String, String, Bool)]?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBAction func displayProjects(_ sender: Any) {
        DispatchQueue.main.async {
            let myVc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectsViewController") as! ProjectsViewController
            myVc.user_projects = self.user_projects
            self.navigationController?.pushViewController(myVc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func displayProfilePicture(cell: ProfileTableViewCell) {
        cell.picture.layer.cornerRadius = cell.picture.frame.size.width / 2;
        cell.picture.layer.borderWidth = 1
        cell.picture.layer.borderColor = UIColor.white.cgColor
        cell.picture.clipsToBounds = true;
 
        let url = user_infos![0].2
        let imageUrl = URL(string: url)
        var error = false
        
        if let u = imageUrl {
            let data = try? Data(contentsOf: u)
            if data == nil {
                error = true
            }
        }
        
        DispatchQueue.main.async {
            if (error == true) {
                let alert = UIAlertController(title: "Error", message: "Cannot access \(url)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                guard let imageData = try? Data(contentsOf: imageUrl!) else {
                    print("Error")
                    return;
                }
                let image = UIImage(data: imageData)
                cell.picture.image = image
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else {
            return 350
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileTableViewCell
            cell.infos = user_infos?[indexPath.row]
            cell.backgroundColor = UIColor.black
            displayProfilePicture(cell: cell)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillsCell") as! SkillsTableViewCell
            cell.user_skills = user_skills
            return cell
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
