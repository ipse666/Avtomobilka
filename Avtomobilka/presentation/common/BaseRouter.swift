//
//  BaseRouter.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 29.07.2023.
//

import UIKit

protocol ClosableRouter {
    var transitionHandler: UIViewController! { get set }
    func close(animated: Bool)
}

extension ClosableRouter {
    func close(animated: Bool) {
        transitionHandler.closeCurrentModule(animated: animated)
    }
}

extension UIViewController {
    func closeCurrentModule(animated: Bool) {
        if let navigationController = parent as? UINavigationController, navigationController.children.count > 1 {
            navigationController.popViewController(animated: animated)
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
        }
    }
}

