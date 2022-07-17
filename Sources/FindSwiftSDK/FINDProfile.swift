//
//  FINDProfile.swift
//
//
//  Created by BoiseITGuru on 7/16/22.
//

import Foundation

public struct FINDProfile: Decodable, Hashable {
    public var findName: String
    public var name: String
    public var description: String
    public var tags: [String]
    public var avatar: String
    public var links: [String]
}
