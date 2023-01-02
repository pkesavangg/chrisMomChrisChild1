//
//  UserDetailsModel.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 25/12/22.
//

import Foundation


struct UserDetails: Hashable, Codable {
    var id = UUID()
    var userMailId : String
    var userName : String
    var documentId: String
    
}

struct PlayerDetailsModel: Hashable, Codable {
    let id = UUID()
    var playerName : String
    var playerMailId : String
    var documentId: String
}
struct MomChildNamesModelDB: Hashable, Codable {
    let id = UUID()
    var momName : String
    var childName : String
    var documentId: String
}

struct MomChildNamesModel: Hashable, Codable {
    let id = UUID()
    var momName : String
    var childName : String
    
}

struct DareMessageModel: Hashable, Codable {
    let id = UUID()
    var childName : String
    var dareMessage : String
    var documentId: String
}
