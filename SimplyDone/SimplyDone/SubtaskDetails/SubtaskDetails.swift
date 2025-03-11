//
//  SubtaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import RealmSwift
import SwiftUI

struct SubtaskDetails: View {

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
                NavigationLink(destination: AddSubtask(viewMode: .edit,
                                                       parentTaskModel: viewModel.parentTaskModel,
                                                       subtaskModel: viewModel.subtaskModel)) {
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
    SubtaskDetails(viewModel: SubtaskDetailsViewModel(
        parentTaskModel: taskModel!,
        subtaskModel: taskModel!.subtasks.first!
    ))
}

@Observable
class SubtaskDetailsViewModel {
    
    let parentTaskModel: TaskModel
    let subtaskModel: SubtaskModel
    let realm = try? Realm()

    init(parentTaskModel: TaskModel, subtaskModel: SubtaskModel) {
        self.parentTaskModel = parentTaskModel
        self.subtaskModel = subtaskModel
    }

    func updateRealmSubtaskStatus() {
        guard let subtask = realm?.objects(Subtask.self).filter({ [weak self] in
            $0.id == self?.subtaskModel.id
        }).first else { return }

        do {
            try realm?.write {
                subtask.status = subtaskModel.status
            }
        } catch {
            // Handle the error here
        }
    }
}
