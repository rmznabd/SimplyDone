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

@Observable
class SubtaskModel: Hashable {
    static func == (lhs: SubtaskModel, rhs: SubtaskModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.taskDescription == rhs.taskDescription &&
        lhs.dueDate == rhs.dueDate &&
        lhs.status == rhs.status
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title + taskDescription)
    }

    var title: String
    var taskDescription: String
    var dueDate: Date?
    var status: String

    init (title: String = "",
          taskDescription: String = "",
          dueDate: Date? = nil,
          status: String = TaskStatus.pending.rawValue) {
        self.title = title
        self.taskDescription = taskDescription
        self.dueDate = dueDate
        self.status = status
    }

    convenience init(realmObject: Subtask) {
        self.init(title: realmObject.title,
                  taskDescription: realmObject.taskDescription,
                  dueDate: realmObject.dueDate,
                  status: realmObject.status)
    }

    func toPersistObject() -> Subtask {
        return Subtask(subtaskModel: self)
    }
}
