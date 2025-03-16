//
//  TaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 01/03/2025.
//

import SwiftUI

struct TaskDetails: View {

    private(set) var viewModel: TaskDetailsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .center) {
                Image(systemName: viewModel.taskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill": "square")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(UIColor.darkGray))
                    .onTapGesture {
                        viewModel.taskModel.status.toggleStatus()
                        viewModel.updateRealmTaskStatus()
                    }

                Text(viewModel.taskModel.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top, 20)

            Text(viewModel.taskModel.taskDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()

            HStack {
                Image(systemName: viewModel.taskModel.dueDate == nil ? "calendar.badge.exclamationmark" : "calendar")
                Text("\(viewModel.taskModel.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No Due Date")")
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
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .onTapGesture { 
                        viewModel.navigateToEditTask()
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

                Image(systemName: "plus")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .onTapGesture {
                        viewModel.navigateToAddNewSubtask()
                    }
            }
            .padding(.horizontal, 10)

            if !viewModel.taskModel.subtasks.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    List {
                        ForEach(viewModel.taskModel.subtasks, id: \.self) { subtaskModel in
                            getSubtaskView(subtaskModel: subtaskModel)
                        }
                        .onDelete { indexSet in
                            guard let firstIndex = indexSet.first else { return }
                            viewModel.deleteRealmSubtask(for: firstIndex)
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
        HStack {
            Image(systemName: subtaskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill" : "square")
                .foregroundColor(.gray)
                .padding(.trailing, 10)
                .onTapGesture {
                    if let subtaskIndex = viewModel.taskModel.subtasks.firstIndex(where: { $0.id == subtaskModel.id }) {
                        self.viewModel.taskModel.subtasks[subtaskIndex].status.toggleStatus()
                        self.viewModel.updateRealmSubtaskStatus(for: subtaskIndex)
                    }
                }

            Text(subtaskModel.title)
                .font(.body)
                .strikethrough(subtaskModel.status == TaskStatus.completed.rawValue, color: .gray)
        }
        .padding(.vertical, 5)
        .onTapGesture {
            viewModel.navigateToSubtaskDetails(for: subtaskModel)
        }
    }
}

#Preview {
    TaskDetails(viewModel: TaskDetailsViewModel(
        taskModel: TaskModel.generatedTaskModels.first!,
        router: .init()
    ))
}
