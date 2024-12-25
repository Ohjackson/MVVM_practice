//
//  TaskViewController.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import SwiftUI
import UIKit

import SnapKit
import Then

final class TaskViewController: UIViewController {
    
    private let viewModel : TaskViewModel
    
    private var taskNameLabel = UILabel()
    private var targetScoreLabel = UILabel()
    private var currentPointLabel = UILabel()
    private var decreaseButton = UIButton()
    private var increaseButton = UIButton()
    
    init(viewModel: TaskViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setStyle()
        setHierarchy()
        setLayout()
        bindViewModel()
        setNavigation()
    }
    
    private func setNavigation(){
        
        navigationItem.title = "Task Details"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(didTapBackButton)
        )
    }
    
    @objc private func didTapBackButton() {
//        navigationController?.popViewController(animated: true)
    }
    
    private func setStyle() {
        
        taskNameLabel.do {
            $0.text = viewModel.taskName
            $0.font = UIFont.boldSystemFont(ofSize: 24)
            $0.textAlignment = .center
        }
        
        targetScoreLabel.do {
            $0.text = "Target Score: \(viewModel.targetScore)"
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.textAlignment = .center
        }
        
        currentPointLabel.do {
            $0.text = "\(viewModel.currentPoint)"
            $0.font = UIFont.boldSystemFont(ofSize: 32)
            $0.textAlignment = .center
        }
        
        decreaseButton.do {
            $0.setTitle("-", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            $0.backgroundColor = .systemRed
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 25
        }
        
        increaseButton.do {
            $0.setTitle("+", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            $0.backgroundColor = .systemGreen
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 25
        }
    }
    
    private func setHierarchy() {
        view.backgroundColor = .white
        view.addSubview(taskNameLabel)
        view.addSubview(targetScoreLabel)
        view.addSubview(currentPointLabel)
        view.addSubview(decreaseButton)
        view.addSubview(increaseButton)
    }
    
    private func setLayout() {
        taskNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
        }
        
        targetScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(taskNameLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        currentPointLabel.snp.makeConstraints { make in
            make.top.equalTo(targetScoreLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        decreaseButton.snp.makeConstraints { make in
            make.top.equalTo(currentPointLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(100)
            make.width.height.equalTo(50)
        }
        
        increaseButton.snp.makeConstraints { make in
            make.top.equalTo(currentPointLabel.snp.bottom).offset(40)
            make.right.equalToSuperview().inset(100)
            make.width.height.equalTo(50)
        }
    }
    
    private func bindViewModel() {
        viewModel.pointUpdated = { [weak self] newPoint in
            guard let self = self else { return }
            self.currentPointLabel.text = "\(newPoint)"
        }
        
        decreaseButton.addTarget(self, action: #selector(didTapDecreaseButton), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(didTapIncreaseButton), for: .touchUpInside)
    }
    
    @objc private func didTapDecreaseButton() {
        viewModel.decreasePoint()
    }
    
    @objc private func didTapIncreaseButton() {
        viewModel.increasePoint()
    }
}
