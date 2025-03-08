//
//  TaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 01/03/2025.
//

import SwiftUI

struct TaskDetails: View {
    @State var task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .center) {
                Image(systemName: task.status == .completed ? "checkmark.square.fill": "square")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(UIColor.darkGray))
                    .onTapGesture {
                        task.status.toggle()
                    }

                Text(task.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top, 20)

            Text(task.description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()

            HStack {
                Image(systemName: task.dueDate == nil ? "calendar.badge.exclamationmark" : "calendar")
                Text("\(task.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No Due Date")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 10)

            Divider()

            subTasksList

            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddTask(viewMode: .edit, task: task)) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
        }
    }

    private var subTasksList: some View {
        Group {
            HStack(alignment: .center) {
                Text("Subtasks")
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                NavigationLink(destination: AddSubTask(viewMode: .create)) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 10)

            if let subTasks = task.subTasks, !subTasks.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    List {
                        ForEach(subTasks, id: \.self) { subTask in
                            NavigationLink(destination: SubTaskDetails(subTask: subTask)) {
                                HStack {
                                    Image(systemName: subTask.status == .completed ? "checkmark.square.fill" : "square")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                        .onTapGesture {
                                            if let taskIndex = task.subTasks?.firstIndex(where: { $0.id == subTask.id }) {
                                                self.task.subTasks?[taskIndex].status.toggle()
                                            }
                                        }

                                    Text(subTask.title)
                                        .font(.body)
                                        .strikethrough(subTask.status == .completed, color: .gray)
                                }
                                .padding(.vertical, 5)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                            // TODO: Remove SubTask here
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
}

#Preview {
    TaskDetails(task: Task.mockTasks.first!)
}
