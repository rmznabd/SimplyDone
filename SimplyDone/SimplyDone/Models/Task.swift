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

    public static let mockTasks: [Task] = [
        Task(
            title: "Decide MeetUp topic",
            description: "Research to find attractive topic to talk about",
            dueDate: Date(),
            isCompleted: false
        ),
        Task(
            title: "Sample project",
            description: "Start to implement sample project",
            dueDate: nil,
            isCompleted: true
        ),
        Task(
            title: "Presentation slides",
            description: "Prepare not boring slides 😄",
            dueDate: nil,
            isCompleted: false
        ),
        Task(
            title: "SwiftUI talk",
            description: "Have a content to speak inclusively",
            dueDate: Date(),
            isCompleted: true
        )
    ]
}
