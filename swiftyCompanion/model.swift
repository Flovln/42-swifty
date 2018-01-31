//
//  model.swift
//  swiftyCompanion
//
//  Created by Florent VIOLIN on 1/25/18.
//  Copyright © 2018 Florent VIOLIN. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataModel {
    static var user_infos : [(String, String, String, String, String, String, String, String)]?
    static var user_skills : [(String, String)]?
    static var user_projects : [(String, String, Bool)]?

    static func treatUserInfos(infos: Any) {
        let json = JSON(infos)
        var display_name : String = "~"
        var email : String = "~"
        var image : String = "~"
        var location : String = "~"
        var phone : String = "~"
        var login : String = "~"
        var level : String = "0"
        var grade : String = "~"

        if let dname = json["displayname"].string {
            display_name = dname
        }
        
        if let e = json["email"].string {
            email = e
        }
        
        if let image_url = json["image_url"].string {
            image = image_url
        }
        
        if let loc = json["location"].string {
            location = loc
        }

        if let p = json["phone"].string {
          phone = p
        }

        if let l = json["login"].string {
            login = l
        }


        if let lvl = json["cursus_users"][0]["level"].double {
            level = String(lvl)
        }
            
        if let g = json["cursus_users"][0]["grade"].string {
            grade = g
        }
        
        self.user_infos = [(display_name, email, image, location, phone, login, level, grade)]
    }
    
    static func treatUserProjects(infos: Any) {
        let json = JSON(infos)
        let projects = json["projects_users"]

        for project in projects {
            let parent_id = project.1["project"]["parent_id"]
            let cursus_id = project.1["cursus_ids"][0]

            if (parent_id == JSON.null && cursus_id != 4) {
                let name = project.1["project"]["name"].stringValue
                let mark = project.1["final_mark"].stringValue
                
                var validated: Bool
                if let v = project.1["validated?"].bool {
                    validated = v
                } else {
                    validated = false
                }

                if self.user_projects == nil {
                    self.user_projects = [(name, mark, validated)]
                }
                else {
                    self.user_projects?.append((name, mark, validated))
                }
            }
        }
    }
    
    static func treatUserSkills(infos: Any) {
        let json = JSON(infos)
        let skills = json["cursus_users"][0]["skills"]
        
        for skill in skills {
            let name = skill.1["name"].stringValue
            let level = skill.1["level"].stringValue
            
            if (self.user_skills == nil) {
                self.user_skills = [(name, level)]
            }
            else {
                self.user_skills?.append((name, level))
            }
        }
    }
    
    static func treatInfos(infos: Any) {
        self.treatUserInfos(infos: infos)
        self.treatUserProjects(infos: infos)
        self.treatUserSkills(infos: infos)
    }
}
