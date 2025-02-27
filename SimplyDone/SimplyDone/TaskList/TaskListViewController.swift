//
//  TaskListViewController.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 27/02/2025.
//

import UIKit

class TaskListViewController: UIViewController {

    private let tasks = Task.mockTasks

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addTask)
        )

        view.addSubview(tableView)
    }

    @objc private func addTask() {
        // TODO: Navigate to SwiftUI Add Task Screen
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        cell.configure(with: task)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let selectedTask = tasks[indexPath.row]
        // TODO: Navigate to SwiftUI Task Details Screen
    }
}
