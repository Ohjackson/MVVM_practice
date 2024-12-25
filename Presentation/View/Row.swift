//
//  Row.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import UIKit

import SnapKit
import Then

class Row: UITableViewCell {
    
    private let idLabel = UILabel()
    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
        setHierarchy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(id: String, name: String) {
        idLabel.text = "ID: \(id)"
        nameLabel.text = name
    }

    private func setStyle() {
        idLabel.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .gray
        }

        nameLabel.do {
            $0.font = .boldSystemFont(ofSize: 16)
            $0.textColor = .black
        }
    }

    private func setHierarchy() {
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
    }

    private func setLayout() {
        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}
