//
//  CarsRouter.swift
//  Avtomobilka
//
//  Created by v.vaskin on 25/07/2023.
//

import UIKit

class CarsRouter: CarsRouterInput {
	weak var transitionHandler: UIViewController!
    weak var navigationController: UINavigationController!

    func openCard(carId: Int) {
        let vc = CardBuilder().configure(carId: carId)
        navigationController = transitionHandler.navigationController
        navigationController.pushViewController(vc, animated: true)
    }
}
