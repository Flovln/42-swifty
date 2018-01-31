//
//  ViewController.swift
//  swiftyCompanion
//
//  Created by Florent VIOLIN on 1/24/18.
//  Copyright © 2018 Florent VIOLIN. All rights reserved.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var token : String?
    var userId : Int?
    var token_expires_in : Int64?
    var token_time_creation : Int64?
    
    @IBOutlet weak var searchStatus: UILabel!
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchAction(_ sender: UIButton) {
        let login = searchInput.text!
        if login.isEmpty {
            return
        }
        
        let trimmed = login.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            return
        }

        self.getUserId(login: trimmed)
    }
    
    func getToken() {
        let url = "https://api.intra.42.fr/oauth/token"
        let parameters: [String: Any] = [
            "grant_type": "client_credentials",
            "client_id": UID,
            "client_secret": SECRET
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                self.token = JSON["access_token"] as? String
                self.token_expires_in = JSON["expires_in"] as? Int64
                
                // get token creation time in seconds
                let date = NSDate()
                self.token_time_creation = Int64(date.timeIntervalSince1970)
            }
        }
        
    }
    
    func getUserInfos() {
        self.searchStatus?.text = "Searching user..."
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let bear = "Bearer " + token!
        let headers: HTTPHeaders = [
            "Authorization" : bear
        ]
        
        let url = "https://api.intra.42.fr/v2/users/\(self.userId!)"
        Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
            DispatchQueue.main.async {
                if (response.result.value != nil) {
                    let json = JSON(response.result.value!)
                    
                    if (json.count > 0) {
                        DataModel.treatInfos(infos: response.result.value!)
                        let myVc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                        myVc.user_infos = DataModel.user_infos
                        myVc.user_skills = DataModel.user_skills
                        myVc.user_projects = DataModel.user_projects

                        self.navigationController?.pushViewController(myVc, animated: true)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        return;
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    return
                }
            }
        }
    }
    
    func getUserId(login: String) {
        
        let params = "\(login.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)"
        let url = "https://api.intra.42.fr/v2/users?filter[login]=\(params)"
        let bear = "Bearer " + token!
        let headers: HTTPHeaders = [
            "Authorization" : bear
        ]
    
        Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
            if (response.result.value != nil) {
                let json = JSON(response.result.value!)

                if (json.count > 0) {
                    self.userId = json[0]["id"].int
                    self.getUserInfos()
                } else {
                    self.searchStatus?.text = login + " could not be found"
                }
            } else {
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        searchButton.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchStatus?.text = ""
        DataModel.user_infos?.removeAll()
        DataModel.user_skills?.removeAll()
        DataModel.user_projects?.removeAll()

        if (token_expires_in != nil) {
            let date = NSDate()
            let token_expiring_time = token_time_creation! + token_expires_in!
            let current_time = Int64(date.timeIntervalSince1970)

            // if token expires, created a new one by calling the wanted api endpoint
            if (token_expiring_time >= current_time) {
                getToken()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

