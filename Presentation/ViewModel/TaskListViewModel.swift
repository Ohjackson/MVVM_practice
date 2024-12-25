//
//  TaskListViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import Foundation

final class TaskListViewModel {
    private(set) var tasks: [TaskModel] = []
    private let folderID: String
    private(set) var folderName: String
    var tasksUpdated: (() -> Void)?

    init(folderID: String, folderName: String) {
        self.folderID = folderID
        self.folderName = folderName
    }

    func fetchTasks() {
        DummyNetworkManager.shared.fetchTasks(for: folderID, taskID: nil) { [weak self] fetchedTasks in
            guard let self = self else { return }
            self.tasks = fetchedTasks
            DispatchQueue.main.async {
                self.tasksUpdated?()
            }
        }
    }

    func addTask(name: String) {
        let newTask = TaskModel(
            id: UUID().uuidString,
            name: name,
            point: 0,
            targetScore: 10
        )
        tasks.append(newTask)
        DispatchQueue.main.async {
            self.tasksUpdated?()
        }
    }
    
    // MARK: - Test용 메서드
       func setDummyTasks(_ dummyTasks: [TaskModel]) {
           self.tasks = dummyTasks
       }
}
