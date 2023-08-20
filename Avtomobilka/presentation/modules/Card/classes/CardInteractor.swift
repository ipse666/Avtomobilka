//
//  CardInteractor.swift
//  Avtomobilka
//
//  Created by v.vaskin on 31/07/2023.
//

import Combine

class CardInteractor: CardInteractorInput {
    weak var output: CardInteractorOutput!
    var carId: Int!
    private var subscriptionCard: AnyCancellable?
    private var subscriptionPosts: AnyCancellable?
    private var page = 1
    private var recentPostsCount = 0

    // MARK: <CardInteractorInput>
    func fetchCard() {
        subscriptionCard = NetworkService.shared.card(id: carId)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Fetch card error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] card in
                guard let self = self else { return }
                output.updateCard(card: card)
            }
    }
    
    func fetchPosts() {
        subscriptionPosts = NetworkService.shared.carPosts(carId: carId, page: page)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Fetch posts error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] posts in
                guard let self = self else { return }
                recentPostsCount = posts.count
                output.updatePots(posts: posts)
            }
    }
    
    func nextPostItems() {
        if recentPostsCount == Constants.Page.itemsCount {
            page += 1
            fetchPosts()
        }
    }
}
