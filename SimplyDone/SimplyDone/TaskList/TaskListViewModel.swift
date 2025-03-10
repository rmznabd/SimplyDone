//
//  TaskListViewModel.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 10/03/2025.
//

import RealmSwift
import SwiftUI

@Observable
final class TaskListViewModel {

    private var taskModels = [TaskModel]()

    let realm = try? Realm()

    func generateTasks() {
        if let result = realm?.objects(Task.self), !result.isEmpty {
            taskModels = Array(result).compactMap { TaskModel(realmObject: $0) }
        } else {
            taskModels = TaskModel.generatedTaskModels
            taskModels.forEach({ taskModel in
                try? realm?.write {
                    realm?.add(taskModel.toPersistObject())
                }
            })
        }
    }

    func deleteTask(for taskModel: TaskModel) {
        guard let tasksToDelete = realm?.objects(Task.self).filter({
            $0.id == taskModel.id
        }) else { return }

        do {
            try realm?.write {
                realm?.delete(tasksToDelete)
            }
        } catch {
            // Handle the error here
        }
    }

    func deleteSubtask(for subtaskModel: SubtaskModel,
                       parentTaskModel: TaskModel) {
        guard let task = realm?.objects(Task.self).filter({
            $0.id == parentTaskModel.id
        }).first else {
            return
        }
        let subtasksToDelete = Array(task.subtasks).filter({
            $0.id == subtaskModel.id
        })
        do {
            try realm?.write {
                realm?.delete(subtasksToDelete)
            }
        } catch {
            // Handle the error here
        }
    }
}

// MARK: UITableView related

extension TaskListViewModel {

    var numberOfSections: Int {
        taskModels.count
    }

    func getNumberOfRows(in section: Int) -> Int {
        taskModels[section].subtasks.count + 1
    }

    func getTaskModel(in section: Int) -> TaskModel {
        taskModels[section]
    }
}
