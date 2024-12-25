//
//  LoginViewModel.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import Foundation

class LoginViewModel {
    
    var userID: String = ""
    
    var loginStatus: ((Bool, String) -> Void)?
    
    private let mockUsers: [UserModel] = [
        UserModel(userID: "user1", name: "Alice", height: 165.0, email: "alice@example.com"),
        UserModel(userID: "user2", name: "Bob", height: 175.0, email: "bob@example.com")
    ]

    func login() {
        guard let user = mockUsers.first(where: { $0.userID == userID }) else {
            loginStatus?(false, "Invalid User ID")
            return
        }

        loginStatus?(true, "Welcome, \(user.name)!")
    }
}
