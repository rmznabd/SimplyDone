//
//  TaskListViewController.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 27/02/2025.
//

import RealmSwift
import SwiftUI
import UIKit

class TaskListViewController: UIViewController {

    private var viewModel = TaskListViewModel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorColor = .clear
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tableView.register(SubtaskCell.self, forCellReuseIdentifier: SubtaskCell.reuseIdentifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.generateTasks()
        tableView.reloadData()
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
        let addTaskScreen = UIHostingController(rootView: AddTask(viewMode: .create, taskModel: TaskModel(id: UUID())))
        addTaskScreen.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(addTaskScreen, animated: true)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskModel = viewModel.getTaskModel(in: indexPath.section)

        if indexPath.row == 0 {
            // Main Task Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
            cell.configure(with: taskModel)
            cell.selectionStyle = .none
            return cell
        } else {
            // Subtask Cell
            let subtaskModel = taskModel.subtasks[indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: SubtaskCell.reuseIdentifier, for: indexPath) as! SubtaskCell
            cell.configure(with: subtaskModel)
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskModel = viewModel.getTaskModel(in: indexPath.section)
            if indexPath.row == 0 {
                viewModel.deleteTask(for: taskModel)
            } else {
                let subtaskModel = taskModel.subtasks[indexPath.row - 1]
                viewModel.deleteSubtask(for: subtaskModel,
                              parentTaskModel: taskModel)
            }
            viewModel.generateTasks()
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskModel = viewModel.getTaskModel(in: indexPath.section)

        if indexPath.row == 0 {
            // Show Task Details
            let taskDetailsScreen = UIHostingController(rootView: TaskDetails(taskModel: taskModel))

            taskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(taskDetailsScreen, animated: true)
        } else {
            // Show Subtask Details
            let subtaskModel = taskModel.subtasks[indexPath.row - 1]
            let subtaskDetailsScreen = UIHostingController(
                rootView: SubtaskDetails(parentTaskModel: taskModel, subtaskModel: subtaskModel)
            )

            subtaskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(subtaskDetailsScreen, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 70 : 50
    }
}
