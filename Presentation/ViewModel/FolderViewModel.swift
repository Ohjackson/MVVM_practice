//
//  FolderViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import Foundation

final class FolderViewModel {
    
    private(set) var folders: [TaskFolderModel] = []
    var foldersUpdated: (() -> Void)?
    var userName: String = "user1" // 현재 사용자 ID
    
    func fetchFolders() {
        DummyNetworkManager.shared.fetchTaskFolders(for: userName) { [weak self] fetchedFolders in
            guard let self = self else { return }
            self.folders = fetchedFolders
            DispatchQueue.main.async {
                self.foldersUpdated?()
            }
        }
    }

    func addFolder(name: String) {
        let newFolder = TaskFolderModel(
            id: UUID().uuidString,
            name: name,
            userID: userName,
            createTime: Date()
        )
        
        // 로컬 업데이트
        folders.append(newFolder)
    
    }
}
