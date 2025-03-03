//
//  AddTask.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import SwiftUI

struct AddTask: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = .now
    @State private var status: TaskStatus = .pending

    var body: some View {
        VStack(spacing: 30) {
            titleInput
            descriptionInput
            dueDateInput
            pickerView

            Button {
                // TODO: Handle Add action here
            } label: {
                Text("Add")
                    .modifier(PrimaryButtonModifier())
            }
            .padding(.top, 120)
        }
        .padding()
        .navigationTitle("Add new Task")
    }

    private var titleInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField("Enter task title", text: $title)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var descriptionInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $description)
                    .frame(minHeight: 100, maxHeight: 200)
                    .multilineTextAlignment(.leading)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )

                if description.isEmpty {
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
            DatePicker("", selection: $dueDate, displayedComponents: .date)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
    }

    private var pickerView: some View {
        Picker("Status", selection: $status) {
            ForEach(TaskStatus.allCases, id: \.self) { status in
                Text(status.rawValue).tag(status)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    AddTask()
}
