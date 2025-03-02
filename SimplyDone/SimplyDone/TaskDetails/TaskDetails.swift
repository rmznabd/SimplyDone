//
//  TaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 01/03/2025.
//

import SwiftUI

enum TaskStatus: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct TaskDetails: View {
    let task: Task
    @Binding var status: TaskStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text(task.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text(task.description)
                .font(.body)
                .foregroundColor(.secondary)

            HStack {
                Image(systemName: "calendar")
                Text("Due Date: \(task.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No Due Date")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Picker("Status", selection: $status) {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .pickerStyle(.segmented)

            if let subTasks = task.subTasks, !subTasks.isEmpty {
                Text("Subtasks")
                    .font(.headline)
                    .padding(.top, 20)

                List {
                    ForEach(subTasks, id: \.self) { subTask in
                        NavigationLink(destination: SubTaskDetails(subTask: subTask, status: .constant(subTask.isCompleted ? .completed : .pending))) {
                            HStack {
                                Image(systemName: subTask.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(subTask.isCompleted ? .gray : .gray)
                                    .padding(.trailing, 10)
                    
                                VStack(alignment: .leading) {
                                    Text(subTask.title)
                                        .font(.body)
                                        .strikethrough(subTask.isCompleted, color: .gray)
                    
                                    Text(subTask.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .onDelete { indexSet in
                        // TODO: Remove SubTask here
                    }
                }
                .listStyle(.plain)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    // TODO: Add edit action here
                }
                .tint(.black)
            }
        }
    }
}

#Preview {
    TaskDetails(
        task: Task.mockTasks.first!,
        status: .constant(.completed)
    )
}
