//
//  AddSubTask.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 03/03/2025.
//

import SwiftUI

enum AddSubTaskViewMode {
    case create
    case edit
}

struct AddSubTask: View {
    let viewMode: AddSubTaskViewMode
    @State private var subTask: SubTask

    init(viewMode: AddSubTaskViewMode, subTask: SubTask? = nil) {
        self.viewMode = viewMode
        _subTask = State(initialValue: subTask ?? SubTask(title: "", description: "", status: .pending))
    }

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput

            Spacer()

            Button {
                // TODO: Handle Add action here
            } label: {
                Text(viewMode == .create ? "Add" : "Save")
                    .modifier(PrimaryButtonModifier())
            }
        }
        .padding()
        .navigationTitle(viewMode == .create ? "Add new SubTask" : "Edit SubTask")
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField("Enter task title", text: $subTask.title)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var descriptionInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $subTask.description)
                    .frame(minHeight: 100, maxHeight: 200)
                    .multilineTextAlignment(.leading)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )

                if subTask.description.isEmpty {
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
    AddSubTask(viewMode: .edit)
}
