//
//  Task.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 27/02/2025.
//

import Foundation

struct Task {
    let title: String
    let description: String
    let dueDate: Date?
    let isCompleted: Bool
    let subTasks: [SubTask]?
}

struct SubTask {
    let title: String
    let description: String
    let isCompleted: Bool
}

// MARK: Mock data below

extension Task {
    public static let mockTasks: [Task] = [
        Task(
            title: "Decide MeetUp topic",
            description: "Research to find attractive topic to talk about",
            dueDate: Date(),
            isCompleted: false,
            subTasks: [
                SubTask(
                    title: "Schedule Meeting",
                    description: "Discuss project initials",
                    isCompleted: false
                ),
                SubTask(
                    title: "Project overview",
                    description: "Write down all steps needs to be done",
                    isCompleted: true
                ),
                SubTask(
                    title: "Project design",
                    description: "How app will look like?",
                    isCompleted: false
                )
            ]
        ),
        Task(
            title: "Sample project",
            description: "Start to implement sample project",
            dueDate: nil,
            isCompleted: true,
            subTasks: nil
        ),
        Task(
            title: "Presentation slides",
            description: "Prepare not boring slides 😄",
            dueDate: nil,
            isCompleted: false,
            subTasks: nil
        ),
        Task(
            title: "SwiftUI talk",
            description: "Have a content to speak inclusively",
            dueDate: Date(),
            isCompleted: true,
            subTasks: [
                SubTask(
                    title: "Schedule a meeting",
                    description: "Discuss all topics",
                    isCompleted: false
                )
            ]
        )
    ]
}
