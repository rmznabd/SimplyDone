//
//  TaskListViewController.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 27/02/2025.
//

import UIKit
import SwiftUI

class TaskListViewController: UIViewController {

    private let tasks = Task.mockTasks

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tableView.register(SubTaskCell.self, forCellReuseIdentifier: SubTaskCell.reuseIdentifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        title = "Tasks"
        navigationController?.navigationBar.tintColor = .black
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let task = tasks[section]
        return (task.subTasks?.count ?? 0) + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.section]

        if indexPath.row == 0 {
            // Main Task Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
            cell.configure(with: task)
            return cell
        } else {
            // SubTask Cell
            let subTask = task.subTasks![indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: SubTaskCell.reuseIdentifier, for: indexPath) as! SubTaskCell
            cell.configure(with: subTask)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: Remove selected task
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.section]

        if indexPath.row == 0 {
            // Show Task Details
            let taskDetailsScreen = UIHostingController(
                rootView: TaskDetails(
                    task: task,
                    status: .constant(task.isCompleted ? .completed : .pending)
                )
            )
            taskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(taskDetailsScreen, animated: true)
        } else {
            // Show SubTask Details
            let subTask = task.subTasks![indexPath.row - 1]
            let subTaskDetailsScreen = UIHostingController(
                rootView: SubTaskDetails(
                    subTask: subTask,
                    status: .constant(subTask.isCompleted ? .completed : .pending)
                )
            )
            subTaskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(subTaskDetailsScreen, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 70 : 50
    }
}
