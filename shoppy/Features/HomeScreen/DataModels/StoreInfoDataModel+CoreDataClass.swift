//
//  StoreInfoDataModel+CoreDataClass.swift
//  shoppy
//
//  Created by YasirRomaya on 8/25/21.
//
//

import Foundation
import CoreData


public class StoreInfoDataModel: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case name, slug, picture, cover, website, email
        case phoneNumber = "phone_number"
        case bio, contact
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String?.self, forKey: .name) ?? ""
            self.slug = try container.decode(String?.self, forKey: .slug) ?? ""
            self.picture = try container.decode(String?.self, forKey: .picture) ?? ""
            self.cover = try container.decode(String?.self, forKey: .cover) ?? ""
            self.website = try container.decode(String?.self, forKey: .website) ?? ""
            self.email = try container.decode(String?.self, forKey: .email) ?? ""
            self.phoneNumber = try container.decode(String?.self, forKey: .phoneNumber) ?? ""
            self.bio = try container.decode(String?.self, forKey: .bio) ?? ""
            self.contact = try container.decode(StoreInfoContactDataModel.self, forKey: .contact)
        }catch let error{
            print(error)
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(slug, forKey: .slug)
        try container.encode(picture, forKey: .picture)
        try container.encode(cover, forKey: .cover)
        try container.encode(website, forKey: .website)
        try container.encode(email, forKey: .email)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(bio, forKey: .bio)
        try container.encode(contact! as StoreInfoContactDataModel, forKey: .contact)
    }
}
