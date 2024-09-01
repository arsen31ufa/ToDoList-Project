//
//  Api.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    private init() {}
    var todos = [TodoEntity]()
    
    func fetchTodos(_ completion: @escaping ([TodoEntity]?, String?) -> Void) {
        let saveDataCore = CoreDataManager.shared.fetchTasksFromCoreData()
        
        
        if !saveDataCore.isEmpty {
            self.todos = saveDataCore
            print("данные уже есть")
            completion(self.todos, nil)
            return
        }else{
            guard let url = URL(string: "https://dummyjson.com/todos") else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to fetch data: \(String(describing: error))")
                    return completion(nil, "Failed to fetch data")
                }
                
                do {
                    let listModel = try JSONDecoder().decode(ListModel.self, from: data)
                    CoreDataManager.shared.saveTodosToCoreData(todos: listModel.todos)
                    self.todos = CoreDataManager.shared.fetchTasksFromCoreData()
                    completion(self.todos, nil)
                    print(self.todos)
                } catch {
                    completion(nil, "Failed to decode JSON: \(error)")
                }
            }
            task.resume()
        }
    }
}
