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

            SubtaskDetailsTitleView(
                status: viewModel.subtaskModel.status,
                toggleStatusAction: viewModel.toggleStatus,
                title: viewModel.subtaskModel.title
            )

            TaskDetailsDescriptionView(description: viewModel.subtaskModel.taskDescription)

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
