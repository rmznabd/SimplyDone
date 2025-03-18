//
//  TaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import SwiftUI
import RealmSwift

@Observable
class TaskDetails {

    let taskModel: TaskModel
    let router: TaskDetailsRouter
    let realm = try? Realm()

    init(taskModel: TaskModel, router: TaskDetailsRouter) {
        self.taskModel = taskModel
        self.router = router
    }

    func deleteRealmSubtask(for index: Int) {
        guard let task = realm?.objects(Task.self).filter({ [weak self] in
            $0.id == self?.taskModel.id
        }).first else { return }

        let subtaskModel = taskModel.subtasks[index]
        let subtasksToDelete = Array(task.subtasks).filter({ $0.id == subtaskModel.id })
        do {
            try realm?.write {
                realm?.delete(subtasksToDelete)
            }
        } catch {
            // Handle the error here
        }
    }

    func toggleStatus() {
        taskModel.status.toggleStatus()
        updateRealmTaskStatus()
    }

    private func updateRealmTaskStatus() {
        guard let task = realm?.objects(Task.self).filter({ [weak self] in
            $0.id == self?.taskModel.id
        }).first else { return }

        do {
            try realm?.write {
                task.status = taskModel.status
            }
        } catch {
            // Handle the error here
        }
    }

    func updateRealmSubtaskStatus(for index: Int) {
        guard let task = realm?.objects(Task.self).filter({ [weak self] in
            $0.id == self?.taskModel.id
        }).first else { return }

        let subtaskModel = taskModel.subtasks[index]
        guard let subtask = Array(task.subtasks).filter({
            $0.id == subtaskModel.id
        }).first else { return }

        do {
            try realm?.write {
                subtask.status = subtaskModel.status
            }
        } catch {
            // Handle the error here
        }
    }

    // MARK: - Navigation

    public func navigateToEditTask() {
        router.navigateToEditTask(for: taskModel)
    }

    public func navigateToAddNewSubtask() {
        router.navigateToAddNewSubtask(for: taskModel)
    }

    public func navigateToSubtaskDetails(for subtask: SubtaskModel) {
        router.navigateToSubtaskDetails(for: taskModel, and: subtask)
    }
}
