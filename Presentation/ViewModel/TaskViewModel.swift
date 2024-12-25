//
//  TaskViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import Foundation

final class TaskViewModel {
    
    private var task: TaskModel?

    init(task: TaskModel) {
           self.task = task
       }
    
    var taskName: String {
        return task?.name ?? "Unknown Task"
    }

    var currentPoint: Int {
        return task?.point ?? 0
    }

    var targetScore: Int {
        return task?.targetScore ?? 0
    }
        //Closure를 사용하여 데이터 변경 이벤트를 전달하기 위한 프로퍼티 ⭐️
    var pointUpdated: ((Int) -> Void)?

    func fetchTask(for userID: String, taskID: String, completion: @escaping () -> Void) {
        DummyNetworkManager.shared.fetchTask(for: userID, taskID: taskID) { [weak self] (fetchedTask: TaskModel?) in
            guard let self = self else { return }
            self.task = fetchedTask
            completion()
        }
    }


    func increasePoint() {
        guard var currentTask = task else { return }
        currentTask.point += 1
        task = currentTask
        pointUpdated?(currentTask.point)
    }

    func decreasePoint() {
        guard var currentTask = task, currentTask.point > 0 else { return }
        currentTask.point -= 1
        task = currentTask
        pointUpdated?(currentTask.point)
    }
}
