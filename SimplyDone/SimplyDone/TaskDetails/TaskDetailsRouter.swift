//
//  TaskDetailsRouter.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import UIKit
import SwiftUI

class TaskDetailsRouter {

    weak var hostingViewController: UIViewController?

    func navigateToEditTask(for task: TaskModel) {
        let router = AddTaskRouter()
        router.hostingViewController = hostingViewController
        let editTaskViewModel = AddTaskViewModel(
            viewMode: .edit,
            taskModel: task,
            router: router
        )

        let editTaskScreen = UIHostingController(rootView: AddTask(viewModel: editTaskViewModel))
        hostingViewController?.navigationController?.pushViewController(editTaskScreen, animated: true)
    }

    func navigateToAddNewSubtask(for task: TaskModel) {
        let router = AddSubtaskRouter()
        router.hostingViewController = hostingViewController
        let addNewSubtaskViewModel = AddSubtaskViewModel(
            viewMode: .create,
            parentTaskModel: task,
            subtaskModel: SubtaskModel(id: UUID()),
            router: router
        )

        let addNewSubtaskScreen = UIHostingController(rootView: AddSubtask(viewModel: addNewSubtaskViewModel))
        hostingViewController?.navigationController?.pushViewController(addNewSubtaskScreen, animated: true)
    }

    func navigateToSubtaskDetails(for parentTask: TaskModel, and subtask: SubtaskModel) {
        let router = SubtaskDetailsRouter()
        router.hostingViewController = hostingViewController
        let subtaskDetailsViewModel = SubtaskDetailsViewModel(
            parentTaskModel: parentTask,
            subtaskModel: subtask,
            router: router
        )

        let subtasksDetailsScreen = UIHostingController(rootView: SubtaskDetails(viewModel: subtaskDetailsViewModel))
        hostingViewController?.navigationController?.pushViewController(subtasksDetailsScreen, animated: true)
    }
}
