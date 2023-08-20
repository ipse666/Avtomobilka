//
//  CarsPresenter.swift
//  Avtomobilka
//
//  Created by v.vaskin on 25/07/2023.
//

import Foundation

class CarsPresenter {

    weak var view: CarsViewInput!
    var interactor: CarsInteractorInput!
    var router: CarsRouterInput!
}

// MARK:- <CarsViewOutput>
extension CarsPresenter: CarsViewOutput {
    func viewIsReady() {
        interactor.carItems()
        view.setupInitialState()
    }

    func backPressed(animated: Bool) {
        router.close(animated: animated)
    }
    
    func openCard(carId: Int) {
        router.openCard(carId: carId)
    }
    
    func nextCarItems() {
        interactor.nextCarItems()
    }
}

// MARK:- <CarsInteractorOutput>
extension CarsPresenter: CarsInteractorOutput {
    func carItems(items: [CarItem]) {
        view.updateCars(items: items)
    }
}
