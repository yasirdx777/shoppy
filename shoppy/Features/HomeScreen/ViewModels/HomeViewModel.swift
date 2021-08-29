//
//  HomeViewModel.swift
//  shoppy
//
//  Created by YasirRomaya on 8/23/21.
//

import Foundation
import UIKit
import CoreData

class HomeViewModel: NSObject {
    
    private var persistentContainer: NSPersistentContainer?
    private var decoder:JSONDecoder?
    
    var bindHomeViewModelToController : (() -> ()) = {}
    
    private(set) var sectionDataModels : [SectionDataModel]! {
        didSet {
            self.bindHomeViewModelToController()
        }
    }
    
    override init() {
        super.init()

        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        persistentContainer = appDelegate.persistentContainer
        decoder = JSONDecoder()
        
        decoder?.userInfo[CodingUserInfoKey.managedObjectContext] = persistentContainer?.viewContext
        
        getHomeViewData()
    }
    
    func getHomeViewData() {
        HttpClient.sharedInstance.request(HttpClientRouter.getHomeData()) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let homeData):
                do{
                    self.clearStorage()
                    
                    _ = try self.decoder?.decode(HomeDataModel.self, from: homeData)
                    
                    try self.persistentContainer?.viewContext.save()
                    
                    if let homeDataModel = self.fetchFromStorage(){
                        var sections = homeDataModel.data?.allObjects as? [SectionDataModel]
                        sections?.sort(by: { $0.createdAt ?? Date() < $1.createdAt ?? Date() })
                        self.sectionDataModels = sections
                    }
                    
                }catch let error{
                    print(error)
                }
            case .failure:
                if let homeDataModel = self.fetchFromStorage(){
                    var sections = homeDataModel.data?.allObjects as? [SectionDataModel]
                    sections?.sort(by: { $0.createdAt ?? Date() < $1.createdAt ?? Date() })
                    self.sectionDataModels = sections
                }
            }
        }
    }
    
    func fetchFromStorage() -> HomeDataModel? {
        do {
            let data = try persistentContainer?.viewContext.fetch(HomeDataModel.fetchRequest()) as? [HomeDataModel]
            return data?.first
            
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func clearStorage() {
        let isInMemoryStore = persistentContainer?.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        } ?? false
        
        if isInMemoryStore {
            
            do {
                let homeDataModel = try persistentContainer?.viewContext.fetch(HomeDataModel.fetchRequest())
                persistentContainer?.viewContext.delete(homeDataModel?.first as! NSManagedObject)
            } catch let error as NSError {
                print(error)
            }
            
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: HomeDataModel.fetchRequest())
            do {
                try persistentContainer?.viewContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
}


