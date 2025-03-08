//
//  SubTaskDetails.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 02/03/2025.
//

import SwiftUI

struct SubTaskDetails: View {
    let subTask: SubTask

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .center) {
                Image(systemName: subTask.status == .completed ? "checkmark.square.fill": "square")
                    .imageScale(.large)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(UIColor.darkGray))

                Text(subTask.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 5)
            }
            .padding(.top, 20)

            Text(subTask.description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
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
    SubTaskDetails(subTask: task!.subTasks!.first!)
}
