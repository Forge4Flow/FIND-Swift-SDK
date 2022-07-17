//
//  FINDProfile.swift
//
//
//  Created by BoiseITGuru on 7/16/22.
//

import Foundation

public struct FINDProfile: Decodable, Hashable {
    var findName: String
    var name: String
    var description: String
    var tags: [String]
    var avatar: String
    var links: [String]
}
