//
//  TaskViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import Foundation

final class TaskViewModel {
    
    
    // ObservablePattern을 사용해 값을 관찰
      let currentPoint: ObservablePattern<Int> = ObservablePattern(0)
      let isTargetAchieved: ObservablePattern<Bool> = ObservablePattern(false)

    
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

    var targetScore: Int {
        return task?.targetScore ?? 0
    }
    
    //네트워크 통신을 가정한 함수
    func fetchTask(taskID: String, completion: @escaping () -> Void) {
        DummyNetworkManager.shared.fetchTask(for: taskID) { [weak self] (fetchedTask: TaskModel?) in
            guard let self = self else { return }
            self.task = fetchedTask
            //ObservablePattern로 선언된 viewModel.currentPoint.value 의 초기값은 0으로 되어 있는데 fetchTask를 통한 업데이트 적용이 되질않아 명시적 선언. -> 해결 안됨
            self.currentPoint.value = fetchedTask?.point ?? 0
            //네트워크 비동기통신으로 인한 딜레이로 모든 데이터를 다 받았을시에 이 함수 호출 주체에게 완료를 알리는 기능
            completion()
        }
    }

    func increasePoint() {
        guard var currentTask = task else { return }
        currentTask.point += 1
        task = currentTask
        
        // ObservablePattern을 통해 값 변경 통지
             currentPoint.value = currentTask.point
             isTargetAchieved.value = currentTask.point >= targetScore
    }

    func decreasePoint() {
        guard var currentTask = task, currentTask.point > 0 else { return }
        currentTask.point -= 1
        task = currentTask
        
        // ObservablePattern을 통해 값 변경 통지
            currentPoint.value = currentTask.point
            isTargetAchieved.value = currentTask.point >= targetScore
    }
}
