//
//  SubtaskDetailsRouter.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import UIKit
import SwiftUI

class SubtaskDetailsRouter {

    weak var hostingViewController: UIViewController?

    func navigateToEditSubtask(for parentTask: TaskModel, and subtask: SubtaskModel) {
        let router = AddSubtaskRouter()
        router.hostingViewController = hostingViewController
        let editSubtaskViewModel = AddSubtaskViewModel(
            viewMode: .edit,
            parentTaskModel: parentTask,
            subtaskModel: subtask,
            router: router
        )

        let editSubtaskScreen = UIHostingController(rootView: AddSubtask(viewModel: editSubtaskViewModel))
        hostingViewController?.navigationController?.pushViewController(editSubtaskScreen, animated: true)
    }
}
