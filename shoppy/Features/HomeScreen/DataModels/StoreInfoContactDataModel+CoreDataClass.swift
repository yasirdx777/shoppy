//
//  StoreInfoContactDataModel+CoreDataClass.swift
//  shoppy
//
//  Created by YasirRomaya on 8/25/21.
//
//

import Foundation
import CoreData


public class StoreInfoContactDataModel: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case address, location, long, lat
        case openDay = "open_day"
        case closeDay = "close_day"
        case openHour = "open_hour"
        case closeHour = "close_hour"
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.address = try container.decode(String?.self, forKey: .address) ?? ""
            self.openDay = try container.decode(String?.self, forKey: .openDay) ?? ""
            self.closeDay = try container.decode(String?.self, forKey: .closeDay) ?? ""
            self.openHour = try container.decode(String?.self, forKey: .openHour) ?? ""
            self.closeHour = try container.decode(String?.self, forKey: .closeHour) ?? ""
        }catch let error{
            print(error)
        }
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address, forKey: .address)
        try container.encode(openDay, forKey: .openDay)
        try container.encode(closeDay, forKey: .closeDay)
        try container.encode(openHour, forKey: .openHour)
        try container.encode(closeHour, forKey: .closeHour)
    }
}
