//
//  API.swift
//  Github_API
//
//  Created by 민도현 on 2022/03/18.
//

import SwiftUI

struct API : Codable{
    var contact : [Contact]
}

struct Contact : Codable {
    var name : String
    var avatar_url : String
    var email : String?
    var followers : Int
    var following : Int
    var url : String
}

    
