//
//  TaskListRouter.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import UIKit
import SwiftUI

class TaskListRouter {
    weak var hostingViewController: UIViewController?

    func navigateToAddTask() {
        let router = AddTaskRouter()
        router.hostingViewController = hostingViewController
        let addTaskViewModel = AddTaskViewModel(viewMode: .create, taskModel: TaskModel(id: UUID()), router: router)

        let addTaskScreen = UIHostingController(rootView: AddTask(viewModel: addTaskViewModel))
        addTaskScreen.navigationItem.largeTitleDisplayMode = .never
        hostingViewController?.navigationController?.pushViewController(addTaskScreen, animated: true)
    }

    func navigateToTaskDetails(for task: TaskModel) {
        let router = TaskDetailsRouter()
        router.hostingViewController = hostingViewController
        let taskDetailsViewModel = TaskDetailsViewModel(taskModel: task, router: router)

        let taskDetailsScreen = UIHostingController(rootView: TaskDetails(viewModel: taskDetailsViewModel))
        taskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
        hostingViewController?.navigationController?.pushViewController(taskDetailsScreen, animated: true)
    }

    func navigateToSubtaskDetail(for subtaskModel: SubtaskModel, parentTaskModel: TaskModel) {
        let router = SubtaskDetailsRouter()
        router.hostingViewController = hostingViewController
        let subtaskDetailsviewModel = SubtaskDetailsViewModel(
            parentTaskModel: parentTaskModel,
            subtaskModel: subtaskModel,
            router: router
        )

        let subtaskDetailsScreen = UIHostingController(rootView: SubtaskDetails(viewModel: subtaskDetailsviewModel))
        subtaskDetailsScreen.navigationItem.largeTitleDisplayMode = .never
        hostingViewController?.navigationController?.pushViewController(subtaskDetailsScreen, animated: true)
    }
}
