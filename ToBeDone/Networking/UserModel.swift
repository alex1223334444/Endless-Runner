//
//  UserModel.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.12.2022.
//

import UIKit

struct User: Codable, Equatable {
    var username: String?
    var lastName: String?
    var uid: String?
    var firstName: String?
    var totalTasks : Int?
    var doneTasks : Int?
    var coins : Int?
    var background1 : Int?
    var background2 : Int?
    var background3 : Int?
    var background4 : Int?
    var avatar1 : Int?
    var avatar2 : Int?
    var avatar3 : Int?
    var avatar4 : Int?
    
    
    func toDictionary() -> [String: Any] {
        return ["username": username, "lastName": lastName, "uid": uid, "firstName" : firstName, "totalTasks": totalTasks, "doneTasks": doneTasks, "coins": coins,
                "background1" : background1,
                "background2" : background2,
                "background3" : background3,
                "background4" : background4,
                "avatar1" : avatar1,
                "avatar2" : avatar2,
                "avatar3" : avatar3,
                "avatar4" : avatar4]
        }
}
