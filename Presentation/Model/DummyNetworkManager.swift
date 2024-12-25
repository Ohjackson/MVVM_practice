//
//  DummyNetworkManager.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import Foundation

import Foundation

final class DummyNetworkManager {
    static let shared = DummyNetworkManager()
    
    private init() {}
    
    private let users: [UserModel] = [
        UserModel(userID: "user1", name: "Alice", height: 165.0, email: "alice@example.com"),
        UserModel(userID: "user2", name: "Bob", height: 175.0, email: "bob@example.com"),
        UserModel(userID: "user3", name: "Charlie", height: 180.0, email: "charlie@example.com")
    ]
    
    private let tasks: [TaskModel] = [
        TaskModel(id: "task1", name: "Do Laundry", point: 5, targetScore: 10),
        TaskModel(id: "task2", name: "Buy Groceries", point: 3, targetScore: 7),
        TaskModel(id: "task3", name: "Read a Book", point: 2, targetScore: 5),
        TaskModel(id: "task4", name: "Clean the House", point: 4, targetScore: 8),
        TaskModel(id: "task5", name: "Exercise", point: 1, targetScore: 6)
    ]

    private let taskFolders: [TaskFolderModel] = [
        TaskFolderModel(id: "folder1", name: "Work", userID: "user1", createTime: Date()),
        TaskFolderModel(id: "folder2", name: "Personal", userID: "user1", createTime: Date()),
        TaskFolderModel(id: "folder3", name: "Hobbies", userID: "user1", createTime: Date())
    ]

    func fetchUsers(completion: @escaping ([UserModel]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(self.users)
        }
    }
    
    func fetchTask(for userID: String, taskID: String, completion: @escaping (TaskModel?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            // Filter the tasks array for the matching taskID
            let task = self.tasks.first { $0.id == taskID }
            completion(task)
        }
    }

    func fetchTaskFolders(for userID: String, completion: @escaping ([TaskFolderModel]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let filteredFolders = self.taskFolders.filter { $0.userID == userID }
            completion(filteredFolders)
        }
    }
    
    func fetchTasks(for folderID: String, taskID: String?, completion: @escaping ([TaskModel]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let tasks = self.tasks.filter { taskID == nil || $0.id == taskID }
            completion(tasks)
        }
    }

}
