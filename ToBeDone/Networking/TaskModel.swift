//
//  TaskModel.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 27.12.2022.
//

import UIKit

struct TaskModel: /*Encodable,Decodable*/Codable, Equatable {
    //var _id : String?
    var title : String?
    var description : String?
    var priority : Int?
    var time: String?
    var tracked: Bool?
    var finished : Bool?
    var uid : String?
    var taskId : String?
    
    /*private enum CodingKeys: String, CodingKey {
        //case _id
        case title
        case description
        case priority
        case time
        case tracked
        case uid
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //_id = try container.decode(String.self, forKey: ._id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        priority = try container.decode(Int.self, forKey: .priority)
        time = try container.decode(String.self, forKey: .time)
        tracked = try container.decode(Bool.self, forKey: .tracked)
        uid = try container.decode(String.self, forKey: .uid)
    }*/
    func toDictionary() -> [String: Any] {
        return ["title": title, "description": description, "priority": priority, "time" : time, "tracked": tracked, "finished": finished, "uid": uid, "taskId": taskId ]
        }
}
