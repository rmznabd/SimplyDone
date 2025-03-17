//
//  SubtaskDetailsView.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import RealmSwift
import SwiftUI

struct SubtaskDetailsView: View {

    private(set) var viewModel: SubtaskDetailsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .center) {
                Image(systemName: viewModel.subtaskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill": "square")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(UIColor.darkGray))
                    .onTapGesture {
                        viewModel.subtaskModel.status.toggleStatus()
                        viewModel.updateRealmSubtaskStatus()
                    }
                
                Text(viewModel.subtaskModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 5)
            }
            .padding(.top, 20)

            Text(viewModel.subtaskModel.taskDescription)
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
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .onTapGesture {
                        viewModel.navigateToEditSubtask()
                    }
            }
        }
    }
}

#Preview {
    let taskModel = TaskModel.generatedTaskModels.first
    SubtaskDetailsView(viewModel: SubtaskDetailsViewModel(
        parentTaskModel: taskModel!,
        subtaskModel: taskModel!.subtasks.first!,
        router: .init()
    ))
}
