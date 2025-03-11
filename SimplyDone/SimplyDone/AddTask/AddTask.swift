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
            return "Add new task"
        case .edit:
            return "Edit task"
        }
    }
}

struct AddTask: View {
    @Environment(\.dismiss) private var dismiss

    private var taskModel: TaskModel

    @State private var viewMode: AddTaskViewMode
    @State private var taskModelTitle: String
    @State private var taskModelDescription: String
    @State private var taskModelDueDate: Date?
    @State private var showAlert = false

    let realm = try? Realm()

    init(viewMode: AddTaskViewMode, taskModel: TaskModel) {
        self.viewMode = viewMode
        self.taskModel = taskModel
        self.taskModelTitle = taskModel.title
        self.taskModelDescription = taskModel.taskDescription
        self.taskModelDueDate = taskModel.dueDate
    }

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput
            dueDateInput

            Spacer()

            Button {
                guard !taskModelTitle.isEmpty, !taskModelDescription.isEmpty else {
                    showAlert = true
                    return
                }

                taskModel.title = taskModelTitle
                taskModel.taskDescription = taskModelDescription
                taskModel.dueDate = taskModelDueDate

                try? realm?.write {
                    if viewMode == .create {
                        realm?.add(taskModel.toPersistObject())
                    } else {
                        guard let task = realm?.objects(Task.self).filter({
                            $0.id == taskModel.id
                        }).first else { return }
                        task.title = taskModelTitle
                        task.taskDescription = taskModelDescription
                        task.dueDate = taskModelDueDate
                    }
                }
                dismiss()
            } label: {
                Text(viewMode.bottomButtonTitle)
                    .modifier(PrimaryButtonModifier())
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("Please fill in both the title and description."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
        .navigationTitle(viewMode.navigationTitle)
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField("Enter task title", text: $taskModelTitle)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var descriptionInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $taskModelDescription)
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
                get: { taskModelDueDate ?? .now },
                set: { taskModelDueDate = $0 }
            ), displayedComponents: .date)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
    }
}

#Preview {
    AddTask(
        viewMode: .edit,
        taskModel: TaskModel(
            id: UUID(),
            title: "Test",
            taskDescription: "Test description",
            subtasks: [SubtaskModel]()
        )
    )
}
