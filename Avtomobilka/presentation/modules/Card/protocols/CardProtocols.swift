//
//  CardProtocols.swift
//  Avtomobilka
//
//  Created by v.vaskin on 31/07/2023.
//

import Foundation

// MARK:- <View>
protocol CardViewInput: AnyObject {
    func setupInitialState()
    func updateCard(card: CardItem)
    func updatePots(posts: [PostItem])
}

protocol CardViewOutput {
    func viewIsReady()
    func backPressed(animated: Bool)
    func nextPostItems()
}


// MARK:- <Interactor>
protocol CardInteractorInput {
    func fetchCard(carId: Int)
    func fetchPosts(carId: Int, page: Int)
}

protocol CardInteractorOutput: AnyObject {
    func updateCard(card: CardItem)
    func updatePots(posts: [PostItem])
}


// MARK:- <Router>
protocol CardRouterInput: ClosableRouter  {

}
