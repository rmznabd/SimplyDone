//
//  AddSubtaskView.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 03/03/2025.
//

import RealmSwift
import SwiftUI

struct AddSubtaskView: View {
    @Bindable private var viewModel: AddSubtask

    init(viewModel: AddSubtask) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 30) {
            AddTaskTitleView(title: $viewModel.subtaskModelTitle)
            AddTaskDescriptionView(description: $viewModel.subtaskModelDescription)
            Spacer()
            AddTaskBottomButtonView(
                title: viewModel.viewMode.bottomButtonTitle,
                action: viewModel.saveSubtask,
                showAlert: $viewModel.showAlert
            )
        }
        .padding()
        .navigationTitle(viewModel.viewMode.navigationTitle)
    }
}

#Preview {
    AddSubtaskView(viewModel: .init(
        viewMode: .edit,
        parentTaskModel: TaskModel(
            id: UUID(),
            title: "Test task",
            taskDescription: "Test description"
        ),
        subtaskModel: SubtaskModel(
            id: UUID(),
            title: "Subtask",
            taskDescription: "Test description"
        ),
        router: .init()
    ))
}
