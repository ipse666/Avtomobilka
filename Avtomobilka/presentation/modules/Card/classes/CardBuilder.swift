//
//  CardBuilder.swift
//  Avtomobilka
//
//  Created by v.vaskin on 31/07/2023.
//

import UIKit

class CardBuilder {

    func configure(carId: Int) -> UIViewController {
        let viewController = UIStoryboard.init(name: "Card", bundle: nil).instantiateInitialViewController() as! CardViewController

        let router = CardRouter()
        router.transitionHandler = viewController

        let presenter = CardPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.carId = carId

        let interactor = CardInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter

        return viewController
    }

}
