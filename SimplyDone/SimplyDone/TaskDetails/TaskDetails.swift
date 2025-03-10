//
//  TaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 01/03/2025.
//

import RealmSwift
import SwiftUI

struct TaskDetails: View {

    private(set) var viewModel: TaskDetailsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .center) {
                Image(systemName: viewModel.taskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill": "square")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(UIColor.darkGray))
                    .onTapGesture {
                        viewModel.taskModel.status.toggleStatus()
                        viewModel.updateRealmTaskStatus()
                    }
                
                Text(viewModel.taskModel.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top, 20)

            Text(viewModel.taskModel.taskDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()

            HStack {
                Image(systemName: viewModel.taskModel.dueDate == nil ? "calendar.badge.exclamationmark" : "calendar")
                Text("\(viewModel.taskModel.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No Due Date")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 10)

            Divider()

            subtasksList

            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddTask(viewMode: .edit, taskModel: viewModel.taskModel)) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
        }
    }

    private var subtasksList: some View {
        Group {
            HStack(alignment: .center) {
                Text("Subtasks")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(
                    destination: AddSubtask(
                    viewMode: .create,
                    parentTaskModel: viewModel.taskModel,
                    subtaskModel: SubtaskModel(id: UUID())
                    )
                ) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 10)

            if !viewModel.taskModel.subtasks.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    List {
                        ForEach(viewModel.taskModel.subtasks, id: \.self) { subtaskModel in
                            getSubtaskView(subtaskModel: subtaskModel)
                        }
                        .onDelete { indexSet in
                            guard let firstIndex = indexSet.first else { return }
                            viewModel.deleteRealmSubtask(for: firstIndex)
                        }
                    }
                    .listStyle(.plain)
                }
            } else {
                VStack(alignment: .center) {
                    Image(systemName: "tray.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                    
                    Text("No subtasks")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .frame(maxWidth: .infinity, minHeight: 150)
            }
        }
    }

    private func getSubtaskView(subtaskModel: SubtaskModel) -> some View {
        NavigationLink(destination: SubtaskDetails(
            viewModel: SubtaskDetailsViewModel(
                parentTaskModel: viewModel.taskModel,
                subtaskModel: subtaskModel
            )
        )) {
            HStack {
                Image(systemName: subtaskModel.status == TaskStatus.completed.rawValue ? "checkmark.square.fill" : "square")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        if let subtaskIndex = viewModel.taskModel.subtasks.firstIndex(where: { $0.id == subtaskModel.id }) {
                            self.viewModel.taskModel.subtasks[subtaskIndex].status.toggleStatus()
                            self.viewModel.updateRealmSubtaskStatus(for: subtaskIndex)
                        }
                    }

                Text(subtaskModel.title)
                    .font(.body)
                    .strikethrough(subtaskModel.status == TaskStatus.completed.rawValue, color: .gray)
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    TaskDetails(viewModel: TaskDetailsViewModel(taskModel: TaskModel.generatedTaskModels.first!))
}

@Observable
class TaskDetailsViewModel {

    let taskModel: TaskModel
    let realm = try? Realm()

    init(taskModel: TaskModel) {
        self.taskModel = taskModel
    }

    func deleteRealmSubtask(for index: Int) {
        guard let task = realm?.objects(Task.self).filter({ [weak self] in
            $0.id == self?.taskModel.id
        }).first else { return }

        let subtaskModel = taskModel.subtasks[index]
        let subtasksToDelete = Array(task.subtasks).filter({ $0.id == subtaskModel.id })
        do {
            try realm?.write {
                realm?.delete(subtasksToDelete)
            }
        } catch {
            // Handle the error here
        }
    }

    func updateRealmTaskStatus() {
        guard let task = realm?.objects(Task.self).filter({ [weak self] in
            $0.id == self?.taskModel.id
        }).first else { return }

        do {
            try realm?.write {
                task.status = taskModel.status
            }
        } catch {
            // Handle the error here
        }
    }

    func updateRealmSubtaskStatus(for index: Int) {
        guard let task = realm?.objects(Task.self).filter({ [weak self] in
            $0.id == self?.taskModel.id
        }).first else { return }

        let subtaskModel = taskModel.subtasks[index]
        guard let subtask = Array(task.subtasks).filter({
            $0.id == subtaskModel.id
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
