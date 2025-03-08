//
//  TaskCell.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 27/02/2025.
//

import UIKit

class TaskCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dueDateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var radioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapRadioButton), for: .touchUpInside)
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
        separatorInset = .init(top: 0, left: 16, bottom: 0, right: 0)
    }

    private func setupUI() {
        contentView.addSubview(radioButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dueDateIcon)
        contentView.addSubview(dueDateLabel)

        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 24),
            radioButton.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dueDateIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dueDateIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            dueDateIcon.widthAnchor.constraint(equalToConstant: 16),
            dueDateIcon.heightAnchor.constraint(equalToConstant: 16),

            dueDateLabel.leadingAnchor.constraint(equalTo: dueDateIcon.trailingAnchor, constant: 6),
            dueDateLabel.centerYAnchor.constraint(equalTo: dueDateIcon.centerYAnchor)
        ])
    }

    func configure(with task: Task) {
        titleLabel.text = task.title

        if let dueDate = task.dueDate {
            dueDateLabel.text = formattedDate(dueDate)
        } else {
            dueDateIcon.image = UIImage(systemName: "calendar.badge.exclamationmark")
            dueDateLabel.text = "No due date"
        }

        if task.status == .completed {
            titleLabel.textColor = .gray
            titleLabel.attributedText = NSAttributedString(
                string: task.title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            radioButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            radioButton.tintColor = .darkGray
        } else {
            titleLabel.textColor = .black
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
            radioButton.tintColor = .gray
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    @objc
    private func didTapRadioButton() {
        print("Task radio button tapped")
        // TODO: Handle radio button action here
    }
}
