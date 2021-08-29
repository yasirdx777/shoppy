//
//  GalleryDataModel+CoreDataClass.swift
//  shoppy
//
//  Created by YasirRomaya on 8/25/21.
//
//

import Foundation
import CoreData


public class GalleryDataModel: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case item
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = Date()
            self.item = try container.decode(String?.self, forKey: .item) ?? ""
        } catch let error{
            print(error)
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(item, forKey: .item)
    }
}
