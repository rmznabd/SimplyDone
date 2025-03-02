//
//  SubTaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import SwiftUI

enum SubTaskStatus: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct SubTaskDetails: View {
    let subTask: SubTask
    @Binding var status: SubTaskStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text(subTask.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text(subTask.description)
                .font(.body)
                .foregroundColor(.secondary)

            Picker("Status", selection: $status) {
                ForEach(SubTaskStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .pickerStyle(.segmented)

            Spacer()
        }
        .padding()
        .navigationTitle("SubTask Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    // TODO: Add edit action here
                }
                .tint(.black)
            }
        }
    }
}

#Preview {
    let task = Task.mockTasks.first
    SubTaskDetails(
        subTask: task!.subTasks!.first!,
        status: .constant(.completed)
    )
}
