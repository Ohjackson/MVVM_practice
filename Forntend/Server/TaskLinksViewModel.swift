//
//  TaskListViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import Foundation
final class TaskLinksViewModel {
    private(set) var tasks: [TaskModel] = []
    private let folderID: String
    private(set) var folderName: String
    var tasksUpdated: (() -> Void)?

    init(folderID: String, folderName: String) {
        self.folderID = folderID
        self.folderName = folderName
    }

    func fetchTasks() {
        tasks = DummyDatabaseManager.shared.fetchTasks(for: folderID)
        DispatchQueue.main.async {
            self.tasksUpdated?()
        }
    }
}
