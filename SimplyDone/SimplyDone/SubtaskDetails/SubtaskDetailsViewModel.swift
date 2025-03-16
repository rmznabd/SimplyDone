//
//  SubtaskDetailsViewModel.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import SwiftUI
import RealmSwift

@Observable
class SubtaskDetailsViewModel {

    let parentTaskModel: TaskModel
    let subtaskModel: SubtaskModel
    let router: SubtaskDetailsRouter
    let realm = try? Realm()

    init(
        parentTaskModel: TaskModel,
        subtaskModel: SubtaskModel,
        router: SubtaskDetailsRouter
    ) {
        self.parentTaskModel = parentTaskModel
        self.subtaskModel = subtaskModel
        self.router = router
    }

    func updateRealmSubtaskStatus() {
        guard let subtask = realm?.objects(Subtask.self).filter({ [weak self] in
            $0.id == self?.subtaskModel.id
        }).first else { return }

        do {
            try realm?.write {
                subtask.status = subtaskModel.status
            }
        } catch {
            // Handle the error here
        }
    }

    // MARK: - Navigation

    public func navigateToEditSubtask() {
        router.navigateToEditSubtask(for: parentTaskModel, and: subtaskModel)
    }
}
