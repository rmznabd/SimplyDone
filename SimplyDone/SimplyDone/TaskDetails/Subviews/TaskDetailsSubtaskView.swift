//
//  TaskDetailsSubtaskView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 18/03/2025.
//

import SwiftUI

struct TaskDetailsSubtaskView: View {

    let status: String
    let toggleStatusAction: () -> Void
    let title: String

    var body: some View {
        HStack {
            Image(systemName: status == TaskStatus.completed.rawValue ? "checkmark.square.fill" : "square")
                .foregroundColor(.gray)
                .padding(.trailing, 10)
                .onTapGesture {
                    toggleStatusAction()
                }

            Text(title)
                .font(.body)
                .strikethrough(status == TaskStatus.completed.rawValue, color: .gray)
        }
        .padding(.vertical, 5)
    }
}
