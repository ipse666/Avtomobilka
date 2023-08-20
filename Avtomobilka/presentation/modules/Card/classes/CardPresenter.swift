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
}

// MARK:- <CardViewOutput>
extension CardPresenter: CardViewOutput {
    func viewIsReady() {
        interactor.fetchCard()
        interactor.fetchPosts()
        view.setupInitialState()
    }

    func backPressed(animated: Bool) {
        router.close(animated: animated)
    }
    
    func nextPostItems() {
        interactor.nextPostItems()
    }
}

// MARK:- <CardInteractorOutput>
extension CardPresenter: CardInteractorOutput {
    func updateCard(card: CardItem) {
        view.updateCard(card: card)
    }
    
    func updatePots(posts: [PostItem]) {
        view.updatePots(posts: posts)
    }
}
