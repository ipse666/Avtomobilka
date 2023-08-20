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
    var page = 1
    var recentCarsCount = 0
}

// MARK:- <CarsViewOutput>
extension CarsPresenter: CarsViewOutput {
    func viewIsReady() {
        interactor.carItems(page: page)
        view.setupInitialState()
    }

    func backPressed(animated: Bool) {
        router.close(animated: animated)
    }
    
    func openCard(carId: Int) {
        router.openCard(carId: carId)
    }
    
    func nextCarItems() {
        if recentCarsCount == Constants.Page.itemsCount {
            page += 1
            interactor.carItems(page: page)
        }
    }
}

// MARK:- <CarsInteractorOutput>
extension CarsPresenter: CarsInteractorOutput {
    func carItems(items: [CarItem]) {
        recentCarsCount = items.count
        view.updateCars(items: items)
    }
}
