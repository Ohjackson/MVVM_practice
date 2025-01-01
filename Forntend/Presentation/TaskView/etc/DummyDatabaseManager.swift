//
//  DummyDatabaseManager.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

// 네트워크 사용을 가장한 임시데이터 셋트임으로 참고만.

import Foundation

final class DummyDatabaseManager {
    static let shared = DummyDatabaseManager()

    private(set) var folderLinks: [TaskFolderLink] = []
    private(set) var tasks: [TaskModel] = []

    private init() {
        setupDummyData()
    }

    private func setupDummyData() {
        // Dummy Task Data
        tasks = [
            TaskModel(id: "task1", name: "Do Laundry", point: 5, targetScore: 10),
            TaskModel(id: "task2", name: "Buy Groceries", point: 3, targetScore: 7),
            TaskModel(id: "task3", name: "Read a Book", point: 2, targetScore: 5),
            TaskModel(id: "task4", name: "Finish Homework", point: 4, targetScore: 10),
            TaskModel(id: "task5", name: "Clean the Room", point: 6, targetScore: 8),
            TaskModel(id: "task6", name: "Exercise", point: 3, targetScore: 6),
            TaskModel(id: "task7", name: "Prepare Presentation", point: 5, targetScore: 10),
            TaskModel(id: "task8", name: "Cook Dinner", point: 4, targetScore: 9),
            TaskModel(id: "task9", name: "Attend Meeting", point: 2, targetScore: 7),
            TaskModel(id: "task10", name: "Watch Tutorial Videos", point: 1, targetScore: 5)
        ]

        // Dummy Folder Link Data
        folderLinks = [
            TaskFolderLink(folderID: "folder1", taskID: "task1"),
            TaskFolderLink(folderID: "folder1", taskID: "task2"),
            TaskFolderLink(folderID: "folder1", taskID: "task3"),
            TaskFolderLink(folderID: "folder2", taskID: "task4"),
            TaskFolderLink(folderID: "folder2", taskID: "task5"),
            TaskFolderLink(folderID: "folder3", taskID: "task6"),
            TaskFolderLink(folderID: "folder3", taskID: "task7"),
            TaskFolderLink(folderID: "folder4", taskID: "task8"),
            TaskFolderLink(folderID: "folder4", taskID: "task9"),
            TaskFolderLink(folderID: "folder5", taskID: "task10")
        ]
    }

    func fetchTasks(for folderID: String) -> [TaskModel] {
        let taskIDs = folderLinks
            .filter { $0.folderID == folderID }
            .map { $0.taskID }
        return tasks.filter { taskIDs.contains($0.id) }
    }
}
