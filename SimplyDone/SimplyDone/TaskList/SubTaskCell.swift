//
//  SubTaskCell.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 28/02/2025.
//

import UIKit

class SubTaskCell: UITableViewCell {
    static let reuseIdentifier = "SubTaskCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let radioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle"), for: .normal) // Empty by default
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        separatorInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 0)
    }

    private func setupUI() {
        contentView.addSubview(radioButton)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 20),
            radioButton.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with subTask: SubTask) {
        titleLabel.text = subTask.title

        if subTask.isCompleted {
            titleLabel.textColor = .gray
            titleLabel.attributedText = NSAttributedString(
                string: subTask.title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            radioButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            radioButton.tintColor = .darkGray
        } else {
            titleLabel.textColor = .black
            radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
            radioButton.tintColor = .gray
        }
    }
}
