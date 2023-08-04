//
//  CarsBuilder.swift
//  Avtomobilka
//
//  Created by v.vaskin on 25/07/2023.
//

import UIKit

class CarsBuilder {

    func configure(viewController: CarsViewController) {
        let router = CarsRouter()
        router.transitionHandler = viewController

        let presenter = CarsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CarsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
