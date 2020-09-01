//
//  SubjectItem.swift
//  Studi-Organizer
//
//  Created by Dima on 02.04.20.
//  Copyright © 2020 Dimitri Achziger. All rights reserved.


import Foundation
import CoreData

public class Subject: NSManagedObject, Identifiable {
    @NSManaged public var name: String?
    @NSManaged public var mark: Double
    @NSManaged public var points: Int16
    

}


extension Subject {
    static func getAllSubjectItems() -> NSFetchRequest<Subject> {
        let request: NSFetchRequest<Subject> = Subject.fetchRequest() as! NSFetchRequest<Subject>

        //let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)

        //request.sortDescriptors = [sortDescriptor]

        return request
    }
}
