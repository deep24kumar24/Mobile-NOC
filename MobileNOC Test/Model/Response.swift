//
//  Response.swift
//  MobileNOC Test
//
//  Created by Deepak Kumar on 2018-12-03.
//  Copyright © 2018 deepak. All rights reserved.
//

import Foundation

struct MobileNOCResponse: Codable {
    let content: [Content]
    let totalPages, totalElements: Int
    let last: Bool
    let sort: JSONNull?
    let numberOfElements: Int
    let first: Bool
    let size, number: Int
}

struct TargetMachine: Codable {
    let id, sourceMachineID: Int
    let targetMachine: Content
    let circuitStatusID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case sourceMachineID = "sourceMachineId"
        case targetMachine
        case circuitStatusID = "circuitStatusId"
    }
}

struct Content: Codable {
    let id: Int
    let name: String
    let ipAddress: String?
    let ipSubnetMask: String?
    let model: Model
    let locationID: Int
    let status: Status
    let type: TypeClass
    let serialNumber, version: String?
    let communicationProtocols: [CommunicationProtocol]
    let targetMachines: [TargetMachine]
    let location: Int
    let serialNum: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, ipAddress, ipSubnetMask, model
        case locationID = "locationId"
        case status, type, serialNumber, version, communicationProtocols, targetMachines, location, serialNum
    }
}

struct CommunicationProtocol: Codable {
    let id: Int
    let name: Name
    let defaultPort: Int
}

enum Name: String, Codable {
    case ssh = "SSH"
    case telnet = "TELNET"
}

//enum IPSubnetMask: String, Codable {
//    case the2552552550 = "255.255.255.0"
//    case the255255255255 = "255.255.255.255"
//}

struct Model: Codable {
    let id: Int
    let name: String
    let creationDate, expiryDate: JSONNull?
}

struct Status: Codable {
    let id: Int
    let statusValue, legacyValue: String
}

struct TypeClass: Codable {
    let id: Int
    let name: String
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
