//
//  AddSubtask.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 03/03/2025.
//

import RealmSwift
import SwiftUI

struct AddSubtask: View {
    @Bindable private var viewModel: AddSubtaskViewModel

    init(viewModel: AddSubtaskViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput
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
            TextField(
                "Enter task title",
                text: $viewModel.subtaskModelTitle
            )
            .textFieldStyle(.roundedBorder)
        }
    }

    private var descriptionInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $viewModel.subtaskModelDescription)
                    .frame(minHeight: 100, maxHeight: 200)
                    .multilineTextAlignment(.leading)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )

                if viewModel.subtaskModelDescription.isEmpty {
                    Text("Enter task description")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                }
            }
        }
    }

    private var button: some View {
        Button {
            viewModel.saveSubtask()
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
    AddSubtask(viewModel: .init(
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
