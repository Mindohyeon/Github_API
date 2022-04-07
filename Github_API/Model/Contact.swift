//
//  API.swift
//  Github_API
//
//  Created by 민도현 on 2022/03/18.
//

import SwiftUI

struct Contact : Codable {
    var name : String
    var avatarUrl : String
    var followers : Int
    var following : Int
    var url : String
    
    enum CodingKeys : String, CodingKey {
        case avatarUrl = "avatar_url"
        case name, following, followers, url
    }
    
}

    
