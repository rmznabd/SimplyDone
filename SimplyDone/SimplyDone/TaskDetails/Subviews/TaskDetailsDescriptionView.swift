//
//  TaskDetailsDescriptionView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 18/03/2025.
//

import SwiftUI

struct TaskDetailsDescriptionView: View {

    let description: String

    var body: some View {
        Text(description)
            .font(.body)
            .foregroundColor(.secondary)
            .padding()
    }
}
