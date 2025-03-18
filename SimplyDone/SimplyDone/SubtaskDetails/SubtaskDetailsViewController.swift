//
//  SubtaskDetailsViewController.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import UIKit

class SubtaskDetailsViewController: UIViewController {

    private var viewModel: SubtaskDetailsViewModel

    private let checkboxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .darkGray
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        return label
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(viewModel: SubtaskDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        updateUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkboxImageView.addGestureRecognizer(tapGesture)

        horizontalStackView.addArrangedSubview(checkboxImageView)
        horizontalStackView.addArrangedSubview(titleLabel)

        view.addSubview(horizontalStackView)
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            checkboxImageView.widthAnchor.constraint(equalToConstant: 25),
            checkboxImageView.heightAnchor.constraint(equalToConstant: 25),

            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 36),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }

    private func setupNavigationBar() {
        title = "Subtask Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(didTapEdit)
        )
    }

    private func updateUI() {
        titleLabel.text = viewModel.subtaskModel.title
        descriptionLabel.text = viewModel.subtaskModel.taskDescription
        updateCheckboxImage()
    }

    private func updateCheckboxImage() {
        let isCompleted = viewModel.subtaskModel.status == TaskStatus.completed.rawValue
        checkboxImageView.image = UIImage(systemName: isCompleted ? "checkmark.square.fill" : "square")
    }

    @objc private func didTapCheckbox() {
        viewModel.toggleStatus()
        updateCheckboxImage()
    }

    @objc private func didTapEdit() {
        viewModel.navigateToEditSubtask()
    }
}
