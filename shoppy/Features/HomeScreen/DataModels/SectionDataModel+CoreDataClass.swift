//
//  SectionDataModel+CoreDataClass.swift
//  shoppy
//
//  Created by YasirRomaya on 8/25/21.
//
//

import Foundation
import CoreData


public class SectionDataModel: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case sectionType = "section_type"
        case sectionID = "section_id"
        case items
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = Date()
            self.title = try container.decode(String?.self, forKey: .title) ?? ""
            self.sectionType = try container.decode(String?.self, forKey: .sectionType) ?? ""
            self.sectionID = try container.decode(String?.self, forKey: .sectionID) ?? ""
            self.items = try container.decode(Set<SectionItemDataModel>?.self, forKey: .items) as NSSet?
        }catch let error{
            print(error)
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(sectionType, forKey: .sectionType)
        try container.encode(sectionType, forKey: .sectionType)
        try container.encode(items as? Set<SectionItemDataModel>, forKey: .items)
    }
}
