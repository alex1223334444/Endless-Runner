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
    
    
    func toDictionary() -> [String: Any] {
        return ["username": username, "lastName": lastName, "uid": uid, "firstName" : firstName, "totalTasks": totalTasks, "doneTasks": doneTasks, "coins": coins]
        }
}
