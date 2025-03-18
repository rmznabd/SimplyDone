//
//  TaskDetailsNoSubtasksListView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 18/03/2025.
//

import SwiftUI

struct TaskDetailsNoSubtasksListView: View {

    var body: some View {
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
