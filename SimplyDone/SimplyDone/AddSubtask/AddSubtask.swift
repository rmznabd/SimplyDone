//
//  AddSubtask.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 03/03/2025.
//

import RealmSwift
import SwiftUI

enum AddSubtaskViewMode {
    case create
    case edit
    
    var bottomButtonTitle: String {
        switch self {
        case .create:
            return "Add"
        case .edit:
            return "Save"
        }
    }

    var navigationTitle: String {
        switch self {
        case .create:
            return "Add new subtask"
        case .edit:
            return "Edit subtask"
        }
    }
}

struct AddSubtask: View {
    private var parentTaskModel: TaskModel
    private var subtaskModel: SubtaskModel

    @Environment(\.dismiss) private var dismiss

    @State private var viewMode: AddSubtaskViewMode
    @State private var subtaskModelTitle: String
    @State private var subtaskModelDescription: String

    let realm = try? Realm()

    init(
        viewMode: AddSubtaskViewMode,
        parentTaskModel: TaskModel,
        subtaskModel: SubtaskModel
    ) {
        self.viewMode = viewMode
        self.parentTaskModel = parentTaskModel
        self.subtaskModel = subtaskModel
        self.subtaskModelTitle = subtaskModel.title
        self.subtaskModelDescription = subtaskModel.taskDescription
    }

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput

            Spacer()

            Button {
                subtaskModel.title = subtaskModelTitle
                subtaskModel.taskDescription = subtaskModelDescription
                guard let task = realm?.objects(Task.self).filter({
                    $0.id == parentTaskModel.id
                }).first else { return }
                try? realm?.write {
                    // TODO: question to Ramazan: should we add or edit the subtask when title or description is empty?
                    if let subtask = Array(task.subtasks).filter({
                        $0.id == subtaskModel.id
                    }).first {
                        subtask.title = subtaskModel.title
                        subtask.taskDescription = subtaskModel.taskDescription
                    } else {
                        parentTaskModel.subtasks.append(subtaskModel)
                        task.subtasks.append(subtaskModel.toPersistObject())
                    }
                }
                dismiss()
            } label: {
                Text(viewMode.bottomButtonTitle)
                    .modifier(PrimaryButtonModifier())
            }
        }
        .padding()
        .navigationTitle(viewMode.navigationTitle)
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField(
                "Enter task title",
                text: $subtaskModelTitle
            )
                .textFieldStyle(.roundedBorder)
        }
    }

    private var descriptionInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(
                    text: $subtaskModelDescription
                )
                    .frame(minHeight: 100, maxHeight: 200)
                    .multilineTextAlignment(.leading)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )

                if subtaskModel.taskDescription.isEmpty {
                    Text("Enter task description")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                }
            }
        }
    }
}

#Preview {
    AddSubtask(
        viewMode: .edit,
        parentTaskModel: TaskModel(id: UUID(), title: "Test task", taskDescription: "Test description"),
        subtaskModel: SubtaskModel(id: UUID(), title: "Subtask", taskDescription: "Test description")
    )
}
