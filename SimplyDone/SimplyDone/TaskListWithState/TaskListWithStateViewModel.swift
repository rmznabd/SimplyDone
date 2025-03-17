//
//  TaskListWithStateViewModel.swift
//  SimplyDone
//
//  Created by Aleh Pachtovy on 17/03/2025.
//

import RealmSwift
import SwiftUI

final class TaskListWithStateViewModel: ObservableObject {

    enum State: Equatable {
        case initial
        case error(String)
        case submitting
        case submitted
    }

    @Published private(set) var state: State

    init() {
        self.state = .initial
    }

    func validateAllTextFields() {
        // Condition 1
        state = .error("Error 1")

        // Condition 2
        // some action
    }

    func submitToServer() {
        state = .submitting

        // API call

        // onSuccess
        state = .submitted
        // router.navigateToSomeScreen()

        // onFailure
        state = .error("Error 2")
    }
}
