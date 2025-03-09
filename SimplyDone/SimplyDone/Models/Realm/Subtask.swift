//
//  Subtask.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 07/03/2025.
//

import Foundation
import RealmSwift

class Subtask: Object, Identifiable {
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var dueDate: Date?
    @Persisted var status: String

    convenience init(subtaskModel: SubtaskModel) {
        self.init()
        title = subtaskModel.title
        taskDescription = subtaskModel.taskDescription
        dueDate = subtaskModel.dueDate
        status = subtaskModel.status
    }
}
