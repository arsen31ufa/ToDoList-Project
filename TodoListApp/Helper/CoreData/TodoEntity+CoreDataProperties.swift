//
//  TodoEntity+CoreDataProperties.swift
//  TodoListApp
//
//  Created by Ars
//
//

import Foundation
import CoreData

@objc(TodoEntity)

public class TodoEntity: NSManagedObject {
    
}

extension TodoEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }
    
    @NSManaged public var id: Int16
    @NSManaged public var userID: Int16
    @NSManaged public var title: String?
    @NSManaged public var descriptonText: String?
    @NSManaged public var date: Date
    @NSManaged public var isCompleted: Bool
    
}

extension TodoEntity : Identifiable {
    
}
