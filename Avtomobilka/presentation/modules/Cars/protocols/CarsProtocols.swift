//
//  CarsProtocols.swift
//  Avtomobilka
//
//  Created by v.vaskin on 25/07/2023.
//

import Foundation

// MARK:- <View>
protocol CarsViewInput: AnyObject {
    func setupInitialState()
    func updateCars(items: [CarItem])
}

protocol CarsViewOutput {
    func viewIsReady()
    func backPressed(animated: Bool)
    func openCard(carId: Int)
    func nextCarItems()
}


// MARK:- <Interactor>
protocol CarsInteractorInput {
    func carItems()
    func nextCarItems()
}

protocol CarsInteractorOutput: AnyObject {
    func carItems(items: [CarItem])
}


// MARK:- <Router>
protocol CarsRouterInput: ClosableRouter  {
    func openCard(carId: Int)
}
