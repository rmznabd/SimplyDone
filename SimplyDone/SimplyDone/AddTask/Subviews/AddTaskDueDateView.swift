//
//  AddTaskDueDateView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 17/03/2025.
//

import SwiftUI

struct AddTaskDueDateView: View {

    @Binding var dueDate: Date?

    var body: some View {
        DatePicker(
            "Due Date:",
            selection: Binding(
                get: { dueDate ?? Date() },
                set: { dueDate = $0 }
            ),
            displayedComponents: .date
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}
