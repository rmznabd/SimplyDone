//
//  TaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 01/03/2025.
//

import RealmSwift
import SwiftUI

struct TaskDetails: View {
    let taskModel: TaskModel
    @Binding var status: TaskStatus
    let realm = try? Realm()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text(taskModel.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text(taskModel.taskDescription)
                .font(.body)
                .foregroundColor(.secondary)

            HStack {
                Image(systemName: "calendar")
                Text("Due Date: \(taskModel.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No Due Date")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Picker("Status", selection: $status) {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .pickerStyle(.segmented)

            subtasksList

            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddTask(viewMode: .edit, taskModel: taskModel)) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
        }
    }

    private func getSubtaskView(subtaskModel: SubtaskModel) -> some View {
        NavigationLink(destination: SubtaskDetails(subtaskModel: subtaskModel, status: .constant(TaskStatus(rawValue: subtaskModel.status) ?? .pending))) {
            HStack {
                Image(systemName: subtaskModel.status == TaskStatus.completed.rawValue ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(subtaskModel.title)
                        .font(.body)
                        .strikethrough(subtaskModel.status == TaskStatus.completed.rawValue, color: .gray)

                    Text(subtaskModel.taskDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 5)
        }
    }

    private var subtasksList: some View {
        Group {
            if !taskModel.subtasks.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        Text("Subtasks")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        NavigationLink(destination: AddSubtask(viewMode: .create, subtaskModel: SubtaskModel())) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top, 20)

                    List {
                        ForEach(taskModel.subtasks, id: \.self) { subtaskModel in
                            getSubtaskView(subtaskModel: subtaskModel)
                        }
                        .onDelete { indexSet in
                            guard let firstIndex = indexSet.first else { return }
                            let subtaskTitle = taskModel.subtasks[firstIndex].title
                            guard let task = realm?.objects(Task.self).filter({
                                $0.title == taskModel.title &&
                                $0.taskDescription == taskModel.taskDescription
                            }).first else {
                                return
                            }
                            let subtasksToDelete = Array(task.subtasks).filter({
                                $0.title == subtaskTitle
                            })
                            do {
                                try realm?.write {
                                    realm?.delete(subtasksToDelete)
                                }
                            } catch {
                                // Handle the error here
                            }
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
        taskModel: TaskModel.generatedTaskModels.first!,
        status: .constant(.completed)
    )
}
