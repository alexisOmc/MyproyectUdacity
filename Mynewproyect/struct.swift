//
//  struct.swift
//  Mynewproyect
//
//  Created by Alexis Omar Marquez Castillo on 04/02/21.
//  Copyright © 2021 udacity. All rights reserved.
//

import Foundation
struct LoctationStudents: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let createdAt, firstName, lastName: String
    let latitude, longitude: Double
    let mapString: String
    let mediaURL: String
    var accountKey: String?
    let objectID, uniqueKey, updatedAt: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case createdAt, firstName, lastName, latitude, longitude, mapString, mediaURL
        case objectID = "objectId"
        case uniqueKey, updatedAt
    }
    
}
struct PostedStudentLocation: Codable {
    let createdAt: String
    let objectId: String
    
}


/*extension StudentLocationList {
 init(mapString: String, mediaURL: String) {
 self.mapString = mapString
 self.mediaURL = mediaURL
 }
 }*/

enum Param: String {
    case updatedAt
}
