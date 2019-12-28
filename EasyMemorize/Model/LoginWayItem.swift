//
//  LogInWayItem.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/8/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation

enum LoginWayItemError: Error {
    case decodeError
}


enum LoginWayItem {
    case pinLogin
    case faceID
    case fingerID
    case none
}


extension LoginWayItem: Codable {
    
    enum CodingKeys: CodingKey {
        case loginWay
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(String.self, forKey: .loginWay)
        switch value {
        case "pinLogin":
            self = .pinLogin
        case "faceID":
            self = .faceID
        case "fingerID":
            self = .fingerID
        case "none":
            self = .none
        default:
            throw LoginWayItemError.decodeError
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .pinLogin:
            try container.encode("pinLogin", forKey: .loginWay)
        case .faceID:
            try container.encode("faceID", forKey: .loginWay)
        case .fingerID:
            try container.encode("fingerID", forKey: .loginWay)
        case .none:
            try container.encode("none", forKey: .loginWay)
        }
    }
}
