//
//  TaskDetailsView.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 01/03/2025.
//

import SwiftUI

struct TaskDetailsView: View {

    private(set) var viewModel: TaskDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            TaskDetailsTitleView(
                status: viewModel.taskModel.status,
                toggleStatusAction: viewModel.toggleStatus,
                title: viewModel.taskModel.title
            )
            TaskDetailsDescriptionView(description: viewModel.taskModel.taskDescription)
            TaskDetailsDueDateView(dueDate: viewModel.taskModel.dueDate)

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
            TaskDetailsSubtasksListHeaderView(navigateToAddNewSubtaskAction: viewModel.navigateToAddNewSubtask)

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
                TaskDetailsNoSubtasksListView()
            }
        }
    }

    private func getSubtaskView(subtaskModel: SubtaskModel) -> some View {
        let toggleStatusAction: () -> Void = {
            if let subtaskIndex = viewModel.taskModel.subtasks.firstIndex(where: { $0.id == subtaskModel.id }) {
                viewModel.taskModel.subtasks[subtaskIndex].status.toggleStatus()
                viewModel.updateRealmSubtaskStatus(for: subtaskIndex)
            }
        }
        return TaskDetailsSubtaskView(status: subtaskModel.status,
                                           toggleStatusAction: toggleStatusAction,
                                           title: subtaskModel.title)
        .onTapGesture {
            viewModel.navigateToSubtaskDetails(for: subtaskModel)
        }
    }
}

#Preview {
    TaskDetailsView(viewModel: TaskDetails(
        taskModel: TaskModel.generatedTaskModels.first!,
        router: .init()
    ))
}
