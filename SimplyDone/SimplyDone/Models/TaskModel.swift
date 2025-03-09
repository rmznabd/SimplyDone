//
//  Task.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 09/03/2025.
//

import Foundation

enum TaskStatus: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

// MARK: - Status togglers

extension String {
    mutating func toggleStatus() {
        self = self == TaskStatus.completed.rawValue ?
        TaskStatus.pending.rawValue :
        TaskStatus.completed.rawValue
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
            taskDescription: "Research to find attractive topic to talk about ak nalsd lskd alsk nalksn dalskn calksnc alksdnc lksnc alksnc alk ncalkn clsknc aslknc alksnc alsknc alkc l l clsckn alsknc lskcn alsckn lscn alc.",
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
