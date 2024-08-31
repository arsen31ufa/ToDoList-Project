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
    var todos: [Todo] = []

    func fetchTodos() {
           guard let url = URL(string: "https://dummyjson.com/todos") else { return }
           
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   print("Failed to fetch data: \(String(describing: error))")
                   return
               }

               do {
                   let listModel = try JSONDecoder().decode(ListModel.self, from: data)
                   CoreDataManager.shared.saveTodosToCoreData(todos: listModel.todos)
                    self.todos = CoreDataManager.shared.fetchTasksFromCoreData()
                   
                   print(self.todos)
               } catch {
                   print("Failed to decode JSON: \(error)")
               }
           }
           task.resume()
       }
}
