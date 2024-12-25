//
//  TaskViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import Foundation

class TaskViewModel {
    private var task: TaskModel

    var taskName: String {
        return task.name
    }

    var currentPoint: Int {
        return task.point
    }

    var targetScore: Int {
        return task.targetScore
    }

    var pointUpdated: ((Int) -> Void)?

    init(task: TaskModel) {
        self.task = task
    }

    func increasePoint() {
        task.point += 1
        pointUpdated?(task.point)
    }

    func decreasePoint() {
        if task.point > 0 {
            task.point -= 1
            pointUpdated?(task.point)
        }
    }
}
