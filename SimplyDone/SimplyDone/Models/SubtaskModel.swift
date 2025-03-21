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
        lhs.status == rhs.status
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: UUID
    var title: String
    var taskDescription: String
    var status: String

    init(id: UUID,
         title: String = "",
         taskDescription: String = "",
         status: String = TaskStatus.pending.rawValue) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.status = status
    }

    convenience init(realmObject: Subtask) {
        self.init(id: realmObject.id,
                  title: realmObject.title,
                  taskDescription: realmObject.taskDescription,
                  status: realmObject.status)
    }

    func toPersistObject() -> Subtask {
        return Subtask(subtaskModel: self)
    }
}
