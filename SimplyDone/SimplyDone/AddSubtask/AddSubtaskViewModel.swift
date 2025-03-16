//
//  AddSubtaskViewModel.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import SwiftUI
import RealmSwift

enum AddSubtaskViewMode {
    case create
    case edit
    
    var bottomButtonTitle: String {
        switch self {
        case .create:
            return "Add"
        case .edit:
            return "Save"
        }
    }

    var navigationTitle: String {
        switch self {
        case .create:
            return "Add new subtask"
        case .edit:
            return "Edit subtask"
        }
    }
}

@Observable
class AddSubtaskViewModel {
    var viewMode: AddSubtaskViewMode
    var subtaskModelTitle: String
    var subtaskModelDescription: String
    var showAlert = false

    let parentTaskModel: TaskModel
    let subtaskModel: SubtaskModel
    private let router: AddSubtaskRouter

    let realm = try? Realm()

    init(
        viewMode: AddSubtaskViewMode,
        parentTaskModel: TaskModel,
        subtaskModel: SubtaskModel,
        router: AddSubtaskRouter
    ) {
        self.viewMode = viewMode
        self.parentTaskModel = parentTaskModel
        self.subtaskModel = subtaskModel
        self.router = router

        self.subtaskModelTitle = subtaskModel.title
        self.subtaskModelDescription = subtaskModel.taskDescription
    }

    func saveSubtask() {
        guard !subtaskModelTitle.isEmpty, !subtaskModelDescription.isEmpty else {
            showAlert = true
            return
        }

        subtaskModel.title = subtaskModelTitle
        subtaskModel.taskDescription = subtaskModelDescription

        guard let task = realm?.objects(Task.self).filter({
            $0.id == self.parentTaskModel.id
        }).first else { return }

        try? realm?.write {
            if let subtask = Array(task.subtasks).filter({
                $0.id == subtaskModel.id
            }).first {
                subtask.title = subtaskModel.title
                subtask.taskDescription = subtaskModel.taskDescription
            } else {
                parentTaskModel.subtasks.append(subtaskModel)
                task.subtasks.append(subtaskModel.toPersistObject())
            }
        }

        router.dismiss()
    }
}
