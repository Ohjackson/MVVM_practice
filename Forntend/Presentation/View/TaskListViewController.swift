//
//  TaskListViewController.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import UIKit

import SnapKit
import Then

final class TaskListViewController: UIViewController {
    private let viewModel: TaskListViewModel
    
    private let tableView = UITableView()
    private let addTaskButton = UIButton()
    private let folderNameLabel = UILabel()
    
    init(viewModel: TaskListViewModel) {
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
        fetchData()
    }
    
    private func setStyle() {
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapBackButton))
            navigationItem.leftBarButtonItem = backButton
        
        folderNameLabel.do {
            $0.font = .boldSystemFont(ofSize: 24)
            $0.textColor = .black
            $0.textAlignment = .center
            $0.text = viewModel.folderName
        }
        
        tableView.do {
            $0.register(Row.self, forCellReuseIdentifier: "TaskCell")
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .singleLine
        }
        
        addTaskButton.do {
            $0.setTitle("+", for: .normal)
            $0.backgroundColor = .systemBlue
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 30)
            $0.layer.cornerRadius = 25
            $0.addTarget(self, action: #selector(didTapAddTaskButton), for: .touchUpInside)
        }
    }
    
    private func setHierarchy() {
        view.addSubview(folderNameLabel)
        view.addSubview(tableView)
        view.addSubview(addTaskButton)
    }
    
    private func setLayout() {
        folderNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(folderNameLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        addTaskButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func bindViewModel() {
        viewModel.tasksUpdated = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func fetchData() {
        viewModel.fetchTasks()
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapAddTaskButton() {
        let alert = UIAlertController(title: "New Task", message: "Enter task name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Task Name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self, let taskName = alert.textFields?.first?.text, !taskName.isEmpty else { return }
            self.viewModel.addTask(name: taskName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? Row else {
            return UITableViewCell()
        }
        let task = viewModel.tasks[indexPath.row]
        cell.configure(id: task.id, name: task.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = viewModel.tasks[indexPath.row]
        
        // TaskViewModel 생성
        let taskViewModel = TaskViewModel(Id: selectedTask.id)

        // TaskViewController 생성
        let taskVC = TaskViewController(viewModel: taskViewModel)
        
        // TaskViewController를 모달로 표시
//        taskVC.modalPresentationStyle = .fullScreen // 또는 .pageSheet
//        present(taskVC, animated: true)
//        
//        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(taskVC, animated: true)

    }
    
}


import SwiftUI

struct TaskListViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            
            let viewModel = TaskListViewModel(folderID: "folder1", folderName: "Work")
            
            return TaskListViewController(viewModel: viewModel)
        }
    }
}
