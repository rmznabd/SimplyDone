//
//  AddTask.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import RealmSwift
import SwiftUI

enum AddTaskViewMode {
    case create
    case edit
}

struct AddTask: View {
    let viewMode: AddTaskViewMode
    private var taskModel: TaskModel
    @Environment(\.dismiss) private var dismiss

    let realm = try? Realm()

    init(viewMode: AddTaskViewMode, taskModel: TaskModel) {
        self.viewMode = viewMode
        self.taskModel = taskModel
    }

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput
            dueDateInput

            Spacer()

            Button {
                try? realm?.write {
                    realm?.add(taskModel.toPersistObject())
                }
                dismiss()
            } label: {
                Text(viewMode == .create ? "Add": "Save")
                    .modifier(PrimaryButtonModifier())
            }
        }
        .padding()
        .navigationTitle(viewMode == .create ? "Add new Task" : "Edit Task")
        
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField(
                "Enter task title",
                text: Binding(
                    get: { taskModel.title },
                    set: { taskModel.title = $0 }
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
                        get: { taskModel.taskDescription },
                        set: { taskModel.taskDescription = $0 }
                    )
                )
                    .frame(minHeight: 100, maxHeight: 200)
                    .multilineTextAlignment(.leading)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )

                if taskModel.taskDescription.isEmpty {
                    Text("Enter task description")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                }
            }
        }
    }

    private var dueDateInput: some View {
        HStack {
            Text("Due Date:")
                .bold()
            Spacer()
            DatePicker("", selection: Binding(
                get: { taskModel.dueDate ?? .now },
                set: { taskModel.dueDate = $0 }
            ), displayedComponents: .date)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
    }
}

#Preview {
    AddTask(viewMode: .edit, taskModel: TaskModel(title: "Test", taskDescription: "Test description", subtasks: [SubtaskModel]()))
}
