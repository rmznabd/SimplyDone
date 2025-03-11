//
//  Subtask.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 07/03/2025.
//

import Foundation
import RealmSwift

class Subtask: Object, Identifiable {
    @Persisted var id: UUID
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var status: String

    convenience init(subtaskModel: SubtaskModel) {
        self.init()
        id = subtaskModel.id
        title = subtaskModel.title
        taskDescription = subtaskModel.taskDescription
        status = subtaskModel.status
    }
}
