//
//  SubtaskCell.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 28/02/2025.
//

import UIKit

class SubtaskCell: UITableViewCell {
    static let reuseIdentifier = "SubtaskCell"

    var onRadioButtonTappedCallback: (() -> Void)?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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

    func configure(with subtaskModel: SubtaskModel) {

        if subtaskModel.status == TaskStatus.completed.rawValue {
            titleLabel.textColor = .gray
            titleLabel.attributedText = NSAttributedString(
                string: subtaskModel.title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            radioButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            radioButton.tintColor = .darkGray
        } else {
            titleLabel.textColor = .black
            titleLabel.attributedText = NSMutableAttributedString(string: subtaskModel.title, attributes: [:])
            titleLabel.text = subtaskModel.title
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
            radioButton.tintColor = .gray
        }
    }

    @objc
    private func didTapRadioButton() {
        onRadioButtonTappedCallback?()
    }
}
