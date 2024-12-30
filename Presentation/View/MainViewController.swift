//
//  MainViewController.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/26/24.
//

import UIKit
import SwiftUI

import SnapKit
import Then

final class MainViewController: UIViewController {
    
    private let viewModel = FolderViewModel()
    
    private let tableView = UITableView()
    private let addFolderButton = UIButton()
    private let nameLabel = UILabel()

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

        nameLabel.do {
            $0.font = .boldSystemFont(ofSize: 24)
            $0.textColor = .black
            $0.textAlignment = .center
        }

        tableView.do {
            $0.register(Row.self, forCellReuseIdentifier: "TaskFolderCell")
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .singleLine
        }

        addFolderButton.do {
            $0.setTitle("+", for: .normal)
            $0.backgroundColor = .systemBlue
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 30)
            $0.layer.cornerRadius = 25
            $0.addTarget(self, action: #selector(didTapAddFolderButton), for: .touchUpInside)
        }
    }

    private func setHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(tableView)
        view.addSubview(addFolderButton)
    }

    private func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        addFolderButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    private func bindViewModel() {
        viewModel.foldersUpdated = { [weak self] in
            guard let self = self else { return }
            self.nameLabel.text = "Welcome"
            self.tableView.reloadData()
        }
    }

    private func fetchData() {
        viewModel.fetchFolders()
    }

    @objc private func didTapAddFolderButton() {
        let alert = UIAlertController(title: "New Folder", message: "Enter folder name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Folder Name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self, let folderName = alert.textFields?.first?.text, !folderName.isEmpty else { return }
            self.viewModel.addFolder(name: folderName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}





extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.folders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskFolderCell", for: indexPath) as? Row else {
            return UITableViewCell()
        }
        let folder = viewModel.folders[indexPath.row]
        cell.configure(id: folder.id, name: folder.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let folder = viewModel.folders[indexPath.row]
           let folderID = folder.id
           let folderName = folder.name

           // ViewModel 생성 및 TaskListViewController로 모달로 표시
           let taskListViewModel = TaskListViewModel(folderID: folderID, folderName: folderName)
           let taskListVC = TaskListViewController(viewModel: taskListViewModel)
        
//           taskListVC.modalPresentationStyle = .fullScreen // 모달 스타일 설정
//           present(taskListVC, animated: true, completion: nil)
            navigationController?.pushViewController(taskListVC, animated: true)

       }
    
}




struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            MainViewController()
        }
    }
}
