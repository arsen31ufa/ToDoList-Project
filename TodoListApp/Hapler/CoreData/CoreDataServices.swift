import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoCoreData")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveTodosToCoreData(todos: [Todo]) {
        let context = persistentContainer.viewContext
        
        // Очистка существующих данных
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            let existingTodos = try context.fetch(fetchRequest)
            for todo in existingTodos {
                context.delete(todo)
            }
        } catch {
            print("Failed to fetch existing todos: \(error)")
        }

        // Сохранение новых данных
        todos.forEach { todoData in
            let todoEntity = TodoEntity(context: context)
            todoEntity.id = Int16(todoData.id)
            todoEntity.userID = Int16(todoData.userID)
            todoEntity.title = todoData.title
            todoEntity.descriptonText = todoData.description
            todoEntity.isCompleted = todoData.isCompleted
            todoEntity.date = todoData.date
        }

        do {
            try context.save()
        } catch {
            print("Failed to save todos: \(error)")
        }
    }
    
    func fetchTasksFromCoreData() -> [Todo] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        
        do {
            let todoEntities = try context.fetch(fetchRequest)
            return todoEntities.map { todoEntity in
                return Todo(id: Int(todoEntity.id),
                            title: todoEntity.title ?? "",
                            isCompleted: todoEntity.isCompleted,
                            userID: Int(todoEntity.userID),
                            description: todoEntity.descriptonText ?? "",
                            date: todoEntity.date)
            }
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
}
