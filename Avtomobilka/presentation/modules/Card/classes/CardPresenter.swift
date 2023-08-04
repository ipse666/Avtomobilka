//
//  CardPresenter.swift
//  Avtomobilka
//
//  Created by v.vaskin on 31/07/2023.
//

import Foundation

class CardPresenter {

    weak var view: CardViewInput!
    var interactor: CardInteractorInput!
    var router: CardRouterInput!
    var carId: Int!
    var page = 1
}

// MARK:- <CardViewOutput>
extension CardPresenter: CardViewOutput {
    func viewIsReady() {
        interactor.fetchCard(carId: carId)
        interactor.fetchPosts(carId: carId, page: page)
        view.setupInitialState()
    }

    func backPressed(animated: Bool) {
        router.close(animated: animated)
    }
    
    func nextPostItems() {
        page += 1
        interactor.fetchPosts(carId: carId, page: page)
    }
}

// MARK:- <CardInteractorOutput>
extension CardPresenter: CardInteractorOutput {
    func updateCard(card: CardItem) {
        DispatchQueue.main.async { [weak self] in
            self?.view.updateCard(card: card)
        }
    }
    
    func updatePots(posts: [PostItem]) {
        DispatchQueue.main.async { [weak self] in
            self?.view.updatePots(posts: posts)
        }
    }
}
