//
//  CoreDataManager.swift
//  CoreDataApp
//
//  Created by We//Yes on 26/05/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager();
    
    let persistentContainer:NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "CoreDataModel");
        container.loadPersistentStores { (desc, err) in
            guard let err = err else { return };
            
            print(err);
            print(desc);
        }
        return container;
    }();
    
    
    func createEmployeee(name: String, comletition: @escaping (Error?) -> ()) {
      let ctx = persistentContainer.viewContext;
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: ctx);
        
        employee.setValue(name, forKey: "name");
        
        do {
            try ctx.save();
            comletition(nil);
        } catch let error {
            print(error);
            comletition(error);
        }
    }
}
