//
//  AddTaskView.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import RealmSwift
import SwiftUI

struct AddTaskView: View {
    @Bindable private var viewModel: AddTask

    init(viewModel: AddTask) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 30) {
            AddTaskTitleView(title: $viewModel.taskModelTitle)
            AddTaskDescriptionView(description: $viewModel.taskModelDescription)
            AddTaskDueDateView(dueDate: $viewModel.taskModelDueDate)
            Spacer()
            AddTaskBottomButtonView(
                title: viewModel.viewMode.bottomButtonTitle,
                action: viewModel.saveTask,
                showAlert: $viewModel.showAlert
            )
        }
        .padding()
        .navigationTitle(viewModel.viewMode.navigationTitle)
    }
}

#Preview {
    AddTaskView(viewModel: .init(
        viewMode: .edit,
        taskModel: TaskModel(
            id: UUID(),
            title: "Test",
            taskDescription: "Test description",
            subtasks: [SubtaskModel]()
        ),
        router: .init())
    )
}
