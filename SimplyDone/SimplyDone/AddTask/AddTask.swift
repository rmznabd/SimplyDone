//
//  AddTask.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import SwiftUI

enum AddTaskViewMode {
    case create
    case edit
}

struct AddTask: View {
    let viewMode: AddTaskViewMode
    @State private var task: Task

    init(viewMode: AddTaskViewMode, task: Task? = nil) {
        self.viewMode = viewMode
        _task = State(initialValue: task ?? Task(title: "", description: "", dueDate: nil, status: .pending, subTasks: nil))
    }

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput
            dueDateInput

            if viewMode == .edit {
                pickerView
            }

            Button {
                // TODO: Handle Add action here
            } label: {
                Text(viewMode == .create ? "Add": "Save")
                    .modifier(PrimaryButtonModifier())
            }
            .padding(.top, 70)

            Spacer()
        }
        .padding()
        .navigationTitle(viewMode == .create ? "Add new Task" : "Edit Task")
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField("Enter task title", text: $task.title)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var descriptionInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $task.description)
                    .frame(minHeight: 100, maxHeight: 200)
                    .multilineTextAlignment(.leading)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )

                if task.description.isEmpty {
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
                get: { task.dueDate ?? .now },
                set: { task.dueDate = $0 }
            ), displayedComponents: .date)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
    }

    private var pickerView: some View {
        Picker("Status", selection: $task.status) {
            ForEach(TaskStatus.allCases, id: \.self) { status in
                Text(status.rawValue).tag(status)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    AddTask(viewMode: .edit)
}
