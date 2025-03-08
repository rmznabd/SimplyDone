//
//  Task.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 27/02/2025.
//

import Foundation

enum TaskStatus: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct Task {
    var title: String
    var description: String
    var dueDate: Date?
    var status: TaskStatus
    var subTasks: [SubTask]?
}

struct SubTask: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var description: String
    var status: TaskStatus
}

// MARK: Mock data below

extension Task {
    public static let mockTasks: [Task] = [
        Task(
            title: "Decide MeetUp topic",
            description: "Research to find attractive topic to talk about ak nalsd lskd alsk nalksn dalskn calksnc alksdnc lksnc alksnc alk ncalkn clsknc aslknc alksnc alsknc alkc l l clsckn alsknc lskcn alsckn lscn alc.",
            dueDate: Date(),
            status: .pending,
            subTasks: [
                SubTask(
                    title: "Schedule Meeting",
                    description: "Discuss project initials",
                    status: .completed
                ),
                SubTask(
                    title: "Project overview",
                    description: "Write down all steps needs to be done",
                    status: .completed
                ),
                SubTask(
                    title: "Project design",
                    description: "How app will look like?",
                    status: .pending
                )
            ]
        ),
        Task(
            title: "Sample project",
            description: "Start to implement sample project",
            dueDate: nil,
            status: .completed,
            subTasks: nil
        ),
        Task(
            title: "Presentation slides",
            description: "Prepare not boring slides 😄",
            dueDate: nil,
            status: .pending,
            subTasks: nil
        ),
        Task(
            title: "SwiftUI talk",
            description: "Have a content to speak inclusively",
            dueDate: Date(),
            status: .completed,
            subTasks: [
                SubTask(
                    title: "Schedule a meeting",
                    description: "Discuss all topics",
                    status: .completed
                )
            ]
        )
    ]
}
