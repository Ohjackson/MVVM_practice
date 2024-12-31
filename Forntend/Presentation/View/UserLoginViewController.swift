//
//  UserLoginViewController.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import UIKit
import SwiftUI

import SnapKit
import Then

final class UserLoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    private var idTextField = UITextField()
    private var loginButton = UIButton(type: .system)
    private var statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setHierarchy()
        setLayout()
        bindViewModel()
    }

    private func setStyle() {
        idTextField.do {
            $0.placeholder = "Enter User ID"
            $0.borderStyle = .roundedRect
        }

        loginButton.do {
            $0.setTitle("Login", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            $0.backgroundColor = .systemBlue
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }

        statusLabel.do {
            $0.textAlignment = .center
            $0.textColor = .red
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.numberOfLines = 0
        }
    }

    private func setHierarchy() {
        view.backgroundColor = .white
        view.addSubview(idTextField)
        view.addSubview(loginButton)
        view.addSubview(statusLabel)
    }

    private func setLayout() {
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }

    private func bindViewModel() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

        viewModel.loginStatus = { [weak self] success, message in
            guard let self = self else { return }
            self.statusLabel.text = message
            self.statusLabel.textColor = success ? .systemGreen : .red

            if success {
                self.navigateToMainView()
            }
        }
    }

    @objc private func didTapLoginButton() {
        viewModel.userID = idTextField.text ?? ""
        viewModel.login()
    }

    private func navigateToMainView() {
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        mainViewController.modalTransitionStyle = .flipHorizontal// 애니

        present(mainViewController, animated: true, completion: nil)
    }
}



struct UserLoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UserLoginViewController()
        }
    }
}

