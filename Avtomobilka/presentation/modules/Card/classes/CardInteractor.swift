//
//  CardInteractor.swift
//  Avtomobilka
//
//  Created by v.vaskin on 31/07/2023.
//

class CardInteractor: CardInteractorInput {
    weak var output: CardInteractorOutput!

    // MARK: <CardInteractorInput>
    func fetchCard(carId: Int) {
        NetworkService.shared.card(id: carId) { [weak self] card in
            self?.output.updateCard(card: card)
        } errorResponse: { error in
            print("Fetch card error: \(error.localizedDescription)")
        }
    }
    
    func fetchPosts(carId: Int, page: Int) {
        NetworkService.shared.carPosts(carId: carId, page: page) { [weak self] posts in
            self?.output.updatePots(posts: posts)
        } errorResponse: { error in
            print("Fetch posts error: \(error.localizedDescription)")
        }
    }
}
