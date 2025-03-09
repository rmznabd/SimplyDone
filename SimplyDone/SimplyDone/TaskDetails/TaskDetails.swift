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
    let realm = try? Realm()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .center) {
                Image(systemName: taskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill": "square")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(UIColor.darkGray))
                    .onTapGesture {
                        taskModel.status.toggleStatus()
                    }
                
                Text(taskModel.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top, 20)

            Text(taskModel.taskDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()

            HStack {
                Image(systemName: taskModel.dueDate == nil ? "calendar.badge.exclamationmark" : "calendar")
                Text("\(taskModel.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No Due Date")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 10)

            Divider()

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

    private var subtasksList: some View {
        Group {
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
            .padding(.horizontal, 10)

            if !taskModel.subtasks.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
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
            } else {
                VStack(alignment: .center) {
                    Image(systemName: "tray.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                    
                    Text("No subtasks")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .frame(maxWidth: .infinity, minHeight: 150)
            }
        }
    }

    private func getSubtaskView(subtaskModel: SubtaskModel) -> some View {
        NavigationLink(destination: SubtaskDetails(subtaskModel: subtaskModel)) {
            HStack {
                Image(systemName: subtaskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill" : "square")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        if let taskIndex = taskModel.subtasks.firstIndex(where: { $0.id == subtaskModel.id }) {
                            self.taskModel.subtasks[taskIndex].status.toggleStatus()
                        }
                    }

                Text(subtaskModel.title)
                    .font(.body)
                    .strikethrough(subtaskModel.status == TaskStatus.completed.rawValue, color: .gray)
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    TaskDetails(taskModel: TaskModel.generatedTaskModels.first!)
}
