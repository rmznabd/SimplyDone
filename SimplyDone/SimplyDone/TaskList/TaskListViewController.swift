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

    private var taskModels = [TaskModel]()

    let realm = try? Realm()

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
        generateTasks()
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
        let addTaskScreen = UIHostingController(rootView: AddTask(viewMode: .create, taskModel: TaskModel()))
        addTaskScreen.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(addTaskScreen, animated: true)
    }

    private func generateTasks() {
        if let result = realm?.objects(Task.self), !result.isEmpty {
            let tasks = Array(result)
            taskModels = tasks.compactMap { TaskModel(realmObject: $0) }
        } else {
            let taskModels = TaskModel.generatedTaskModels
            taskModels.forEach({ taskModel in
                try? realm?.write {
                    realm?.add(taskModel.toPersistObject())
                }
            })
        }
        tableView.reloadData()
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskModels.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskModel = taskModels[section]
        return taskModel.subtasks.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskModel = taskModels[indexPath.section]

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
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskModel = taskModels[indexPath.section]
            let tasksToDelete = realm?.objects(Task.self).filter({
                $0.title == taskModel.title
            })
            do {
                if let objects = tasksToDelete {
                    try realm?.write {
                        realm?.delete(objects)
                    }
                }
            } catch {
                // Handle the error here
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskModel = taskModels[indexPath.section]

        if indexPath.row == 0 {
            // Show Task Details
            let taskDetailsScreen = UIHostingController(rootView: TaskDetails(taskModel: taskModel))

            taskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(taskDetailsScreen, animated: true)
        } else {
            // Show Subtask Details
            let subtaskModel = taskModel.subtasks[indexPath.row - 1]
            let subtaskDetailsScreen = UIHostingController(rootView: SubtaskDetails(subtaskModel: subtaskModel))

            subtaskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(subtaskDetailsScreen, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 70 : 50
    }
}
