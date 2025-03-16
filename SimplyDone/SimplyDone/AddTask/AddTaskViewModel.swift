//
//  AddTaskViewModel.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import SwiftUI
import RealmSwift

enum AddTaskViewMode {
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
            return "Add new task"
        case .edit:
            return "Edit task"
        }
    }
}

@Observable
class AddTaskViewModel {
    var taskModelTitle: String
    var taskModelDescription: String
    var taskModelDueDate: Date?
    var showAlert = false

    let taskModel: TaskModel
    let viewMode: AddTaskViewMode
    private let router: AddTaskRouter

    private let realm = try? Realm()

    init(viewMode: AddTaskViewMode, taskModel: TaskModel, router: AddTaskRouter) {
        self.viewMode = viewMode
        self.taskModel = taskModel
        self.router = router

        self.taskModelTitle = taskModel.title
        self.taskModelDescription = taskModel.taskDescription
        self.taskModelDueDate = (viewMode == .edit) ? taskModel.dueDate : nil
    }

    func saveTask() {
        guard !taskModelTitle.isEmpty, !taskModelDescription.isEmpty else {
            showAlert = true
            return
        }

        taskModel.title = taskModelTitle
        taskModel.taskDescription = taskModelDescription
        taskModel.dueDate = taskModelDueDate

        try? realm?.write {
            if viewMode == .create {
                realm?.add(taskModel.toPersistObject())
            } else {
                guard let task = realm?.objects(Task.self).filter({ $0.id == self.taskModel.id }).first else { return }
                task.title = taskModelTitle
                task.taskDescription = taskModelDescription
                task.dueDate = taskModelDueDate
            }
        }

        router.dismissAddTaskScreen()
    }
}
