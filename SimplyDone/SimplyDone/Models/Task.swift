//
//  Task.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 07/03/2025.
//

import Foundation
import RealmSwift

enum TaskStatus: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

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

@Observable
class TaskModel {
    var title: String
    var taskDescription: String
    var dueDate: Date?
    var status: String
    var subtasks: [SubtaskModel]

    init (title: String = "",
          taskDescription: String = "",
          dueDate: Date? = nil,
          status: String = TaskStatus.pending.rawValue,
          subtasks: [SubtaskModel] = [SubtaskModel]()) {
        self.title = title
        self.taskDescription = taskDescription
        self.dueDate = dueDate
        self.status = status
        self.subtasks = subtasks
    }

    convenience init(realmObject: Task) {
        self.init(title: realmObject.title,
                  taskDescription: realmObject.taskDescription,
                  dueDate: realmObject.dueDate,
                  status: realmObject.status,
                  subtasks: Array(realmObject.subtasks).compactMap { SubtaskModel(realmObject: $0) }
        )
    }

    func toPersistObject() -> Task {
        return Task(taskModel: self)
    }
}

extension TaskModel {

    static let generatedTaskModels: [TaskModel] = {
        var subtaskModels1: [SubtaskModel] = [
            SubtaskModel(
                title: "Schedule Meeting",
                taskDescription: "Discuss project initials",
                dueDate: Date(),
                status: TaskStatus.completed.rawValue
            ),
            SubtaskModel(
                title: "Project overview",
                taskDescription: "Write down all steps needs to be done",
                dueDate: Date(),
                status: TaskStatus.completed.rawValue
            ),
            SubtaskModel(
                title: "Project design",
                taskDescription: "How app will look like?",
                dueDate: Date(),
                status: TaskStatus.pending.rawValue
            )
        ]
        var taskModel1 = TaskModel(
            title: "Decide MeetUp topic",
            taskDescription: "Research to find attractive topic to talk about",
            dueDate: Date(),
            status: TaskStatus.pending.rawValue,
            subtasks: subtaskModels1
        )
        var taskModel2 = TaskModel(
            title: "Sample project",
            taskDescription: "Start to implement sample project",
            dueDate: nil,
            status: TaskStatus.completed.rawValue,
            subtasks: []
        )
        var taskModel3 = TaskModel(
            title: "Presentation slides",
            taskDescription: "Prepare not boring slides 😄",
            dueDate: nil,
            status: TaskStatus.pending.rawValue,
            subtasks: []
        )

        var subtaskModels4: [SubtaskModel] = [
            SubtaskModel(
                title: "Schedule a meeting",
                taskDescription: "Discuss all topics",
                dueDate: Date(),
                status: TaskStatus.completed.rawValue
            )
        ]
        var taskModel4 = TaskModel(
            title: "SwiftUI talk",
            taskDescription: "Have a content to speak inclusively",
            dueDate: Date(),
            status: TaskStatus.completed.rawValue,
            subtasks: subtaskModels4
        )
        return [
            taskModel1,
            taskModel2,
            taskModel3,
            taskModel4
        ]
    }()
}
