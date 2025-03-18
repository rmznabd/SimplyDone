//
//  TaskDetailsSubtasksListHeaderView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 18/03/2025.
//

import SwiftUI

struct TaskDetailsSubtasksListHeaderView: View {

    let navigateToAddNewSubtaskAction: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            Text("Subtasks")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()

            Image(systemName: "plus")
                .imageScale(.large)
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
                .onTapGesture {
                    navigateToAddNewSubtaskAction()
                }
        }
        .padding(.horizontal, 10)
    }
}
