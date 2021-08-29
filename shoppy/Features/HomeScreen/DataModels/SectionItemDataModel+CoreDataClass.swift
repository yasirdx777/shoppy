//
//  SectionItemDataModel+CoreDataClass.swift
//  shoppy
//
//  Created by YasirRomaya on 8/25/21.
//
//

import Foundation
import CoreData


public class SectionItemDataModel: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case name, picture, slug, type
        case parentID = "parent_id"
        case categoryName = "category_name"
        case itemDescription = "description"
        case price
        case monthlyInstallment = "monthly_installment"
        case currency, attributes
        case isWarranty = "is_warranty"
        case warrantyLength = "warranty_length"
        case warrantyDuration = "warranty_duration"
        case galleries
        case monthsOfDeduction = "months_of_deduction"
        case storeInfo = "store_info"
        case visitsCount = "visits_count"
        case cover, website, email
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
            
            self.createdAt = Date()
            
            do{
                self.name = try container.decode(String?.self, forKey: .name) ?? ""
            }catch {
                
            }
            
            do{
                self.picture = try container.decode(String?.self, forKey: .picture) ?? ""
            }catch {
                
            }
            
            do{
                self.slug = try container.decode(String?.self, forKey: .slug) ?? ""
                
            }catch {
                
            }
            
            do{
                self.type = try container.decode(String?.self, forKey: .type) ?? ""
            }catch {
                
            }
            
            do{
                self.parentID = try container.decode(Int64?.self, forKey: .parentID) ?? 0
            }catch {
                
            }
            
            do{
                self.categoryName = try container.decode(String?.self, forKey: .categoryName) ?? ""
            }catch {
                
            }
            
            do{
                self.itemDescription = try container.decode(String?.self, forKey: .itemDescription) ?? ""
            }catch {
                
            }
            
            do{
                self.price = try container.decode(String?.self, forKey: .price) ?? ""
            }catch {
                
            }
            
            do{
                self.monthlyInstallment = try container.decode(String?.self, forKey: .monthlyInstallment) ?? ""
            }catch {
                
            }
            
            do{
                self.currency = try container.decode(String?.self, forKey: .currency) ?? ""
            }catch {
                
            }
            
            do{
                self.attributes = try container.decode(Set<AttributeDataModel>.self, forKey: .attributes) as NSSet
            }catch {
                
            }
            
            do{
                self.isWarranty = try container.decode(Bool?.self, forKey: .isWarranty) ?? false
            }catch {
                
            }
            
            do{
                self.warrantyLength = try container.decode(Int64?.self, forKey: .warrantyLength) ?? 0
            }catch {
                
            }
            
            do{
                self.warrantyDuration = try container.decode(String?.self, forKey: .warrantyDuration) ?? ""
            }catch {
                
            }
            
            do{
                self.galleries = try container.decode(Set<GalleryDataModel>?.self, forKey: .galleries) as NSSet?
            }catch {
                
            }
            
            do{
                self.monthsOfDeduction = try container.decode(Int64?.self, forKey: .monthsOfDeduction) ?? 0
            }catch {
                
            }
            
            do{
                self.storeInfo = try container.decode(StoreInfoDataModel?.self, forKey: .storeInfo)
            }catch {
                
            }
            
            do{
                self.visitsCount = try container.decode(Int64?.self, forKey: .visitsCount) ?? 0
            }catch {
                
            }
            
            do{
                self.cover = try container.decode(String?.self, forKey: .cover) ?? ""
            }catch {
                
            }
            
            do{
                self.website = try container.decode(String?.self, forKey: .website) ?? ""
            }catch {
                
            }
            
            do{
                self.email = try container.decode(String?.self, forKey: .email) ?? ""
            }catch {
                
            }
            
            do{
                self.phoneNumber = try container.decode(String?.self, forKey: .phoneNumber) ?? ""
            }catch {
                
            }
            
            do{
                self.contact = try container.decode(ContactDataModel?.self, forKey: .contact)
            }catch {
                
            }
            
        }catch {
            
        }
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(picture, forKey: .picture)
        try container.encode(slug, forKey: .slug)
        try container.encode(type, forKey: .type)
        try container.encode(parentID, forKey: .parentID)
        try container.encode(categoryName, forKey: .categoryName)
        try container.encode(itemDescription, forKey: .itemDescription)
        try container.encode(price, forKey: .price)
        try container.encode(monthlyInstallment, forKey: .monthlyInstallment)
        try container.encode(currency, forKey: .currency)
        try container.encode(attributes as? Set<GalleryDataModel>, forKey: .attributes)
        try container.encode(isWarranty, forKey: .isWarranty)
        try container.encode(warrantyLength, forKey: .warrantyLength)
        try container.encode(warrantyDuration, forKey: .warrantyDuration)
        try container.encode(galleries as? Set<SectionItemDataModel>, forKey: .galleries)
        try container.encode(monthsOfDeduction, forKey: .monthsOfDeduction)
        try container.encode(storeInfo! as StoreInfoDataModel, forKey: .storeInfo)
        try container.encode(visitsCount, forKey: .visitsCount)
        try container.encode(cover, forKey: .cover)
        try container.encode(website, forKey: .website)
        try container.encode(email, forKey: .email)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(bio, forKey: .bio)
        try container.encode(contact! as ContactDataModel, forKey: .contact)
    }
    
    
}
