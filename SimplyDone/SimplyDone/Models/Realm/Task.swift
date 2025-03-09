//
//  Task.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 07/03/2025.
//

import Foundation
import RealmSwift

class Task: Object, Identifiable {
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var dueDate: Date?
    @Persisted var status: String
    @Persisted var subtasks: List<Subtask>

    convenience init(taskModel: TaskModel) {
        self.init()
        title = taskModel.title
        taskDescription = taskModel.taskDescription
        dueDate = taskModel.dueDate
        status = taskModel.status
        let subtasksList = List<Subtask>()
        for subtaskModel in taskModel.subtasks {
            subtasksList.append(Subtask(subtaskModel: subtaskModel))
        }
        subtasks = subtasksList
    }
}
