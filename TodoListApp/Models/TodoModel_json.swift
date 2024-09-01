//
//  TodoModel_json.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import Foundation

// MARK: - ListModel
struct ListModel: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let title: String
    var isCompleted: Bool
    let userID: Int
    
    var description: String = ""
    var date: Date = Date.randomFutureDate()
    
    enum CodingKeys: String, CodingKey {
        case id
        case isCompleted = "completed"
        case title = "todo"
        case userID = "userId"
    }
}

