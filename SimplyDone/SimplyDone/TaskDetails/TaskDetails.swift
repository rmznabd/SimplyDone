//
//  TaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 01/03/2025.
//

import SwiftUI

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

            subTasksList

            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddTask(viewMode: .edit, task: task)) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
        }
    }

    private var subTasksList: some View {
        Group {
            if let subTasks = task.subTasks, !subTasks.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        Text("Subtasks")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        NavigationLink(destination: AddSubTask(viewMode: .create)) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top, 20)

                    List {
                        ForEach(subTasks, id: \.self) { subTask in
                            NavigationLink(destination: SubTaskDetails(subTask: subTask, status: .constant(subTask.status))) {
                                HStack {
                                    Image(systemName: subTask.status == .completed ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)

                                    VStack(alignment: .leading) {
                                        Text(subTask.title)
                                            .font(.body)
                                            .strikethrough(subTask.status == .completed, color: .gray)

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
