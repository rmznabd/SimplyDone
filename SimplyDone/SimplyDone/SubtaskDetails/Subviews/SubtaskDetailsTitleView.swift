//
//  SubtaskDetailsTitleView.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 18/03/2025.
//

import SwiftUI

struct SubtaskDetailsTitleView: View {

    let status: String
    let toggleStatusAction: () -> Void
    let title: String

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: status == TaskStatus.completed.rawValue ? "checkmark.square.fill": "square")
                .imageScale(.large)
                .frame(width: 30, height: 30)
                .foregroundColor(Color(UIColor.darkGray))
                .onTapGesture {
                    toggleStatusAction()
                }
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 5)
        }
        .padding(.top, 20)
    }
}
