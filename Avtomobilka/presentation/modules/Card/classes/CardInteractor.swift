//
//  CardInteractor.swift
//  Avtomobilka
//
//  Created by v.vaskin on 31/07/2023.
//

import Combine

class CardInteractor: CardInteractorInput {
    weak var output: CardInteractorOutput!
    private var subscriptionCard: AnyCancellable?
    private var subscriptionPosts: AnyCancellable?

    // MARK: <CardInteractorInput>
    func fetchCard(carId: Int) {
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
    
    func fetchPosts(carId: Int, page: Int) {
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
                output.updatePots(posts: posts.posts)
            }
    }
}
