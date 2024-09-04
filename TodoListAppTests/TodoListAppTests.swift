//
//  TodoListAppTests.swift
//  TodoListAppTests
//
//  Created by Have Dope on 03.09.2024.
//

import XCTest

@testable import TodoListApp
import XCTest
import CoreData

final class TodoEntityTests: XCTestCase {
    
    var persistentContainer: NSPersistentContainer!
    var context: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        super.setUp()
        persistentContainer = NSPersistentContainer(name: "TodoCoreData")
        persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = persistentContainer.viewContext
    }
    
    override func tearDownWithError() throws {
        context = nil
        persistentContainer = nil
        super.tearDown()
    }
    
    func testCreateTodoEntity() throws {
        let todo = TodoEntity(context: context)
        todo.id = 1
        todo.userID = 1
        todo.title = "Sample Task"
        todo.descriptonText = "Description of the task"
        todo.date = Date()
        todo.isCompleted = false
        
        do {
            try context.save()
        } catch {
            XCTFail("Failed to save context: \(error)")
        }
        
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        let results = try context.fetch(fetchRequest)
        
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.title, "Sample Task")
    }
}


final class TasksBoardTests: XCTestCase {
    
    var tasksBoard: TasksBoard!
    var context: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        super.setUp()
        
        // Создаем NSPersistentContainer для тестирования
        let persistentContainer = NSPersistentContainer(name: "TodoCoreData")
        persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        context = persistentContainer.viewContext
        
        // Создаем тестовый TasksBoard
        tasksBoard = TasksBoard(dataProperty: .today, todoList: [])
    }
    
    override func tearDownWithError() throws {
        tasksBoard = nil
        context = nil
        super.tearDown()
    }
    
    func testSetUpVstack() throws {
        let todo1 = TodoEntity(context: context)
        todo1.id = 1
        todo1.userID = 1
        todo1.title = "Task 1"
        todo1.descriptonText = "Description 1"
        todo1.date = Date()
        todo1.isCompleted = false
        
        let todo2 = TodoEntity(context: context)
        todo2.id = 2
        todo2.userID = 2
        todo2.title = "Task 2"
        todo2.descriptonText = "Description 2"
        todo2.date = Date()
        todo2.isCompleted = false
        
        try context.save()
        
        let todoList = [todo1, todo2]
        
        tasksBoard = TasksBoard(dataProperty: .today, todoList: todoList)
        tasksBoard.setUpVstack(with: todoList)
        
        XCTAssertEqual(tasksBoard.returnVStackViewCount(), 2, "Получили 2 таски ! ")
    }
}
