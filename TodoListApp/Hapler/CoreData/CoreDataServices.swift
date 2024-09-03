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
    
    func fetchTasksFromCoreData() -> [TodoEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        
        do {
            let todoEntities = try context.fetch(fetchRequest)
            return todoEntities // Возвращаем массив TodoEntity без преобразования
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
    
    func saveTodoNewTask(
        todoEntity:TodoEntity? = nil,
        title: String?,
        description: String?,
        date: Date
    ) -> [TodoEntity] {
        let context = persistentContainer.viewContext
        
        let todoEntityToSave: TodoEntity
        
        if let existingTodo = todoEntity {
            todoEntityToSave = existingTodo
            print("Обновили задачу")
        } else {
            todoEntityToSave = TodoEntity(context: context)
            todoEntityToSave.id = Int16(0)
            todoEntityToSave.userID = Int16(99)
            todoEntityToSave.isCompleted = false
            print("Создали задачу")

        }
        todoEntityToSave.title = title
        todoEntityToSave.descriptonText = description
        todoEntityToSave.date = date
        
        do {
            try context.save()
            print("Todo saved or updated successfully")
        } catch {
            print("Failed to save or update todo: \(error)")
        }
        
        let updatedTodoList = CoreDataManager.shared.fetchTasksFromCoreData()
        return updatedTodoList
    }
    
    func deleteTodoTask(todo: TodoEntity) -> [TodoEntity] {
        let context = persistentContainer.viewContext
        context.delete(todo)
        
        do {
            try context.save()
            print("Todo deleted successfully")
        } catch {
            print("Failed to delete todo: \(error)")
        }
        let updatedTodoList = CoreDataManager.shared.fetchTasksFromCoreData()
        return updatedTodoList
    }
    
}
