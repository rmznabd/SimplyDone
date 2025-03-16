//
//  AddSubtaskRouter.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 16/03/2025.
//

import UIKit

class AddSubtaskRouter {
    weak var hostingViewController: UIViewController?

    func dismiss() {
        hostingViewController?.navigationController?.popViewController(animated: true)
    }
}
