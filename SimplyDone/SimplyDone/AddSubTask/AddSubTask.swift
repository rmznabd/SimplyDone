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
}

struct AddSubtask: View {
    let viewMode: AddSubtaskViewMode
    private var subtaskModel: SubtaskModel
    let realm = try? Realm()

    init(viewMode: AddSubtaskViewMode, subtaskModel: SubtaskModel) {
        self.viewMode = viewMode
        self.subtaskModel = subtaskModel
    }

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput

            Spacer()

            Button {
                try? realm?.write {
                    realm?.add(subtaskModel.toPersistObject())
                }
            } label: {
                Text(viewMode == .create ? "Add" : "Save")
                    .modifier(PrimaryButtonModifier())
            }
        }
        .padding()
        .navigationTitle(viewMode == .create ? "Add new Subtask" : "Edit Subtask")
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField(
                "Enter task title",
                text: Binding(
                    get: { subtaskModel.title },
                    set: { subtaskModel.title = $0 }
                )
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
                    text: Binding(
                        get: { subtaskModel.taskDescription },
                        set: { subtaskModel.taskDescription = $0 }
                    )
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
    AddSubtask(viewMode: .edit, subtaskModel: SubtaskModel(title: "Subtask", taskDescription: "Test description"))
}
