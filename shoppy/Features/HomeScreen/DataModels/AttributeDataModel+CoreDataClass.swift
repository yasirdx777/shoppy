//
//  AttributeDataModel+CoreDataClass.swift
//  shoppy
//
//  Created by YasirRomaya on 8/25/21.
//
//

import Foundation
import CoreData


public class AttributeDataModel: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case value
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            self.createdAt = Date()
            self.name = try container.decode(String?.self, forKey: .name) ?? ""
            self.value = try container.decode(String?.self, forKey: .value) ?? ""
        }catch let error{
            print(error)
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(value, forKey: .value)
    }
}
