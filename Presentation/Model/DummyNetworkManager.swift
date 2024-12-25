//
//  DummyNetworkManager.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import Foundation

final class DummyNetworkManager {
    static let shared = DummyNetworkManager()
    
    private init() {}
    
    func fetchUsers(completion: @escaping ([UserModel]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let users = [
                UserModel(userID: "user1", name: "Alice", height: 165.0, email: "alice@example.com"),
                UserModel(userID: "user2", name: "Bob", height: 175.0, email: "bob@example.com")
            ]
            completion(users)
        }
    }
    
    func fetchTasks(for userID: String, taskID: String, completion: @escaping (TaskModel?) -> Void) {
         DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
             let tasks = [
                 TaskModel(id: "task1", name: "Do Laundry", point: 5, targetScore: 10),
                 TaskModel(id: "task2", name: "Buy Groceries", point: 3, targetScore: 7),
                 TaskModel(id: "task3", name: "Read a Book", point: 2, targetScore: 5)
             ]
             
             // Filter the task based on userID and taskID
             let task = tasks.first { $0.id == taskID }
             completion(task)
         }
     }
}
