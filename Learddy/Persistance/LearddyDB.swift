//
//  LearddyDB.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 22/06/21.
//

import Foundation
import CoreData

class LearddyDB {
    static let shared = LearddyDB()
    
    lazy var learddyContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Learddy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func addLearddy(learnTitle: String, timeResult: Int64, timeSelect: Int64, tanggal: Date) {
        let learddy = Leardy(context: learddyContainer.viewContext)
        learddy.id_leardy = UUID().uuidString
        learddy.learn_title = learnTitle
        learddy.tanggal = tanggal
        learddy.time_result = timeResult
        learddy.time_select = timeSelect
        save()
    }
    
    func save () {
        let context = learddyContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchLeardy() -> [Leardy] {
        let request: NSFetchRequest<Leardy> = Leardy.fetchRequest()
        
        var leardy: [Leardy] = []
        
        do {
            leardy = try learddyContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching authors")
        }
        return leardy
    }
    
}
