//
//  SubtaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import SwiftUI

struct SubtaskDetails: View {
    let subtaskModel: SubtaskModel
    @Binding var status: TaskStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text(subtaskModel.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text(subtaskModel.taskDescription)
                .font(.body)
                .foregroundColor(.secondary)

            Picker("Status", selection: $status) {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .pickerStyle(.segmented)

            Spacer()
        }
        .padding()
        .navigationTitle("Subtask Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddSubtask(viewMode: .edit, subtaskModel: subtaskModel)) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    let taskModel = TaskModel.generatedTaskModels.first
    SubtaskDetails(
        subtaskModel: taskModel!.subtasks.first!,
        status: .constant(.pending)
    )
}
