//
//  AddTaskTitleView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 17/03/2025.
//

import SwiftUI

struct AddTaskTitleView: View {

    @Binding var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title")
                .font(.headline)
            TextField("Enter task title", text: $title)
                .textFieldStyle(.roundedBorder)
        }
    }
}
