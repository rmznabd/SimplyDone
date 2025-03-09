//
//  SubtaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import SwiftUI

struct SubtaskDetails: View {
    let subtaskModel: SubtaskModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .center) {
                Image(systemName: subtaskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill": "square")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(UIColor.darkGray))
                
                Text(subtaskModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 5)
            }
            .padding(.top, 20)

            Text(subtaskModel.taskDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
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
    SubtaskDetails(subtaskModel: taskModel!.subtasks.first!)
}
