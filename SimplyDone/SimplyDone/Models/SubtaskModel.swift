//
//  Subtask.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 09/03/2025.
//

import Foundation

@Observable
class SubtaskModel: Hashable {
    static func == (lhs: SubtaskModel, rhs: SubtaskModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.taskDescription == rhs.taskDescription &&
        lhs.dueDate == rhs.dueDate &&
        lhs.status == rhs.status
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id = UUID()
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
