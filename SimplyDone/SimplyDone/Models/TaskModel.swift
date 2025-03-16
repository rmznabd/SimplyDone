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
    let id: UUID
    var title: String
    var taskDescription: String
    var dueDate: Date?
    var status: String
    var subtasks: [SubtaskModel]

    init (id: UUID,
          title: String = "",
          taskDescription: String = "",
          dueDate: Date? = nil,
          status: String = TaskStatus.pending.rawValue,
          subtasks: [SubtaskModel] = [SubtaskModel]()) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.dueDate = dueDate
        self.status = status
        self.subtasks = subtasks
    }

    convenience init(realmObject: Task) {
        self.init(id: realmObject.id,
                  title: realmObject.title,
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
                id: UUID(),
                title: "Investigate the Cause",
                taskDescription: "Is it out of beans, water, or just in protest?",
                status: TaskStatus.completed.rawValue
            ),
            SubtaskModel(
                id: UUID(),
                title: "Emergency Coffee Run",
                taskDescription: "Send a brave soul to the nearest café.",
                status: TaskStatus.pending.rawValue
            ),
            SubtaskModel(
                id: UUID(),
                title: "Coffee Machine Training",
                taskDescription: "Ensure no one causes this disaster again.",
                status: TaskStatus.pending.rawValue
            )
        ]
        var subtaskModels2: [SubtaskModel] = [
            SubtaskModel(
                id: UUID(),
                title: "Assemble the Pitch",
                taskDescription: "Gather SwiftUI's benefits in a convincing deck.",
                status: TaskStatus.completed.rawValue
            ),
            SubtaskModel(
                id: UUID(),
                title: "Defend Against Legacy Resistance",
                taskDescription: "Address concerns about UIKit’s reliability.",
                status: TaskStatus.completed.rawValue
            ),
            SubtaskModel(
                id: UUID(),
                title: "SwiftUI Showcase",
                taskDescription: "Build a small, sleek prototype to prove its power.",
                status: TaskStatus.pending.rawValue
            ),
            SubtaskModel(
                id: UUID(),
                title: "Final Decision Meeting",
                taskDescription: "Present your case and hope for the green light!",
                status: TaskStatus.pending.rawValue
            )
        ]

        var taskModel1 = TaskModel(
            id: UUID(),
            title: "Conquer the Coffee Crisis ☕️",
            taskDescription: "The office coffee machine is broken, and productivity is at risk. Assemble a plan to restore caffeine levels!",
            dueDate: Date(),
            status: TaskStatus.pending.rawValue,
            subtasks: subtaskModels1
        )
        var taskModel2 = TaskModel(
            id: UUID(),
            title: "SwiftUI Revolution: Win Over Management",
            taskDescription: "The resistance is strong, but SwiftUI is the future! Persuade the higher-ups to embrace the change.",
            dueDate: Calendar.current.date(byAdding: .day, value: 10, to: Date()),
            status: TaskStatus.pending.rawValue,
            subtasks: subtaskModels2
        )
        var taskModel3 = TaskModel(
            id: UUID(),
            title: "Use the Gym Membership 💪🏽",
            taskDescription: "You’ve been paying for that gym membership for months. Time to actually go.",
            dueDate: nil,
            status: TaskStatus.completed.rawValue,
            subtasks: []
        )

        return [
            taskModel1,
            taskModel2,
            taskModel3
        ]
    }()
}
