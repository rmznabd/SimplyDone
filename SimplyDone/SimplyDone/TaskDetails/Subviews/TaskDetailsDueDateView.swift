//
//  TaskDetailsDueDateView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 18/03/2025.
//

import SwiftUI

struct TaskDetailsDueDateView: View {

    let dueDate: Date?

    var body: some View {
        HStack {
            Image(systemName: dueDate == nil ? "calendar.badge.exclamationmark" : "calendar")
            Text("\(dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No Due Date")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 10)
    }
}
