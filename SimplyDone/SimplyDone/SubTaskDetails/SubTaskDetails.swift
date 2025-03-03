//
//  SubTaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import SwiftUI

struct SubTaskDetails: View {
    let subTask: SubTask
    @Binding var status: TaskStatus

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
                ForEach(TaskStatus.allCases, id: \.self) { status in
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
                NavigationLink(destination: AddSubTask(viewMode: .edit, subTask: subTask)) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
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
