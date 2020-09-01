//
//  CoreDataManager.swift
//  Studi-Organizer
//
//  Created by Dima on 02.04.20.
//  Copyright © 2020 Dimitri Achziger. All rights reserved.
//

//import UIKit
//import CoreData
//
//class CoreDataManager {
//
//    static let shared = CoreDataManager()
//
//    var subjects = [Subject]()
//
//    // Kontext als Variable, Referenz zu AppDelegate
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    private init() {
//        loadItems()
//    }
//
//
//    //Objekte erstellen
//    func createObj(name: String, mark: Double) {
//        let subject = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: context) as! Subject
//        subject.name = name
//        subject.mark = mark
//        saveContext()
//        print("create: ", name)
//    }
//
//    //Objekte laden
//    func loadItems() {
//        let request = NSFetchRequest<Subject>(entityName: "Subject")
//
//        do {
//            subjects = try context.fetch(request)
//            print("request loeded")
//        } catch  {
//            print(error.localizedDescription)
//        }
//    }
//
//    func getNumberOfItems() -> Int {
//        return subjects.count
//    }
//
//    func getItems() -> [Subject] {
//        print("getItems")
//        return self.subjects
//    }
//
//    func deleteItem(index: Int) {
//        print("length: ", getNumberOfItems())
//        context.delete(subjects.remove(at: index))
//        saveContext()
//
//        print("deleted in Manager at Position: ", index)
//        print("new length: ", getNumberOfItems())
//    }
//
//    //Kontext speichern
//    func saveContext() {
//        do {
//            try context.save()
//        } catch  {
//            print(error.localizedDescription)
//        }
//    }
//}
