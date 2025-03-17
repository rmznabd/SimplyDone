//
//  AddTaskBottomButtonView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 17/03/2025.
//

import SwiftUI

struct AddTaskBottomButtonView: View {

    let title: String
    let action: () -> Void
    @Binding var showAlert: Bool
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .modifier(PrimaryButtonModifier())
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Missing Information"),
                message: Text("Please fill in both the title and description."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
