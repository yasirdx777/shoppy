//
//  HomeDataModel+CoreDataClass.swift
//  shoppy
//
//  Created by YasirRomaya on 8/25/21.
//
//

import Foundation
import CoreData

public class HomeDataModel: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.message = try container.decode(String?.self, forKey: .message) ?? ""
            self.data = try container.decode(Set<SectionDataModel>?.self, forKey: .data) as NSSet?
        }catch let error{
            print(error)
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(data as? Set<SectionDataModel>, forKey: .data)
    }
    
}
