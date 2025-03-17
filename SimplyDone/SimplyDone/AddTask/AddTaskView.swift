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
            titleInput
            descriptionInput
            dueDateInput
            Spacer()
            button
        }
        .padding()
        .navigationTitle(viewModel.viewMode.navigationTitle)
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField("Enter task title", text: $viewModel.taskModelTitle)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var descriptionInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $viewModel.taskModelDescription)
                    .frame(minHeight: 100, maxHeight: 200)
                    .multilineTextAlignment(.leading)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )

                if viewModel.taskModelDescription.isEmpty {
                    Text("Enter task description")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                }
            }
        }
    }

    private var dueDateInput: some View {
        DatePicker(
            "Due Date:",
            selection: Binding(
                get: { viewModel.taskModelDueDate ?? Date() },
                set: { viewModel.taskModelDueDate = $0 }
            ),
            displayedComponents: .date
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }

    private var button: some View {
        Button {
            viewModel.saveTask()
        } label: {
            Text(viewModel.viewMode.bottomButtonTitle)
                .modifier(PrimaryButtonModifier())
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Missing Information"),
                message: Text("Please fill in both the title and description."),
                dismissButton: .default(Text("OK"))
            )
        }
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
