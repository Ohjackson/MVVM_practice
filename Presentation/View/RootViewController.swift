//
//  RootNavigationView.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import UIKit

import SnapKit
import Then

final class RootViewController: UIViewController {
    
    private let buttonA = UIButton()
    private let buttonB = UIButton()
    private let buttonC = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setHierarchy()
        setLayout()
        setActions()
    }

    private func setStyle() {
        view.backgroundColor = .white
        navigationItem.title = "Root Navigation"

        buttonA.do {
            $0.setTitle("Go to Screen A", for: .normal)
            $0.backgroundColor = .systemBlue
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }

        buttonB.do {
            $0.setTitle("Go to Screen B", for: .normal)
            $0.backgroundColor = .systemGreen
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }

        buttonC.do {
            $0.setTitle("Go to Screen C", for: .normal)
            $0.backgroundColor = .systemRed
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }
    }

    private func setHierarchy() {
        view.addSubview(buttonA)
        view.addSubview(buttonB)
        view.addSubview(buttonC)
    }

    private func setLayout() {
        buttonA.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        buttonB.snp.makeConstraints { make in
            make.top.equalTo(buttonA.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        buttonC.snp.makeConstraints { make in
            make.top.equalTo(buttonB.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    private func setActions() {
        buttonA.addTarget(self, action: #selector(navigateToScreenA), for: .touchUpInside)
        buttonB.addTarget(self, action: #selector(navigateToScreenB), for: .touchUpInside)
        buttonC.addTarget(self, action: #selector(navigateToScreenC), for: .touchUpInside)
    }

    @objc private func navigateToScreenA() {
        let screenA = UserLoginViewController()
        navigationController?.pushViewController(screenA, animated: true)
    }

    @objc private func navigateToScreenB() {
        let screenB = UserLoginViewController()
        navigationController?.pushViewController(screenB, animated: true)
    }

    @objc private func navigateToScreenC() {
        // TaskModel을 생성
        let task = TaskModel(id: "task1", name: "Sample Task", point: 5, targetScore: 10)
        
        // TaskViewModel 생성
        let taskViewModel = TaskViewModel(task: task)
        
        // TaskViewController 생성 시 ViewModel 전달
        let screenC = TaskViewController(viewModel: taskViewModel)
        navigationController?.pushViewController(screenC, animated: true)
    }

}
