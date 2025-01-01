//
//  TaskViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import Foundation

final class TaskViewModel {
    
    //네트워크로 담겨질 데이터 바구니
    private var task: TaskModel?

    //이전뷰에서 받은 아이디 #1
    let taskID: String

    init(Id: String) {
           self.taskID = Id
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

    
    //네트워크 통신을 가정한 함수
    func fetchTask(taskID: String, completion: @escaping () -> Void) {
        DummyNetworkManager.shared.fetchTask(for: taskID) { [weak self] (fetchedTask: TaskModel?) in
            guard let self = self else { return }
            self.task = fetchedTask
            //네트워크 비동기통신으로 인한 딜레이로 모든 데이터를 다 받았을시에 이 함수 호출 주체에게 완료를 알리는 기능
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
