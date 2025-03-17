//
//  TaskListWithStateViewController.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 17/03/2025.
//

import Combine
import UIKit

class TaskListWithStateViewController: TaskListViewController {

    private var cancellable: AnyCancellable?
    let viewModel: TaskListWithStateViewModel

    let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .medium
        view.hidesWhenStopped = true
        view.stopAnimating()
        view.accessibilityIdentifier = "taskListWithStateScreen.spinner"
        return view
    }()

    init(viewModel: TaskListWithStateViewModel,
         parentViewModel: TaskListViewModel) {
        self.viewModel = viewModel

        super.init(viewModel: parentViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubscriptions()
    }

    func configureSubscriptions() {
        cancellable = viewModel.$state.sink { [weak self] state in
            self?.render(state)
        }
    }

    func render(_ state: TaskListWithStateViewModel.State) {
        switch state {
        case .initial:
            setupUI()
        case .error(let error):
            showErrorAlert(error)
        case .submitting:
            spinner.startAnimating()
        case .submitted:
            spinner.stopAnimating()
        }
    }

    func setupUI() {}

    func showErrorAlert(_ error: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: error,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: "Close",
            style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc private func tapOnContinueButton() {
        viewModel.submitToServer()
    }
}
