//
//  CarsInteractor.swift
//  Avtomobilka
//
//  Created by v.vaskin on 25/07/2023.
//

import Combine

class CarsInteractor: CarsInteractorInput {
    weak var output: CarsInteractorOutput!
    private var subscription: AnyCancellable?

    // MARK: <CarsInteractorInput>
    func carItems(page: Int) {
        subscription = NetworkService.shared.cars(page: page)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Fetch cars list error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] carItems in
                guard let self = self else { return }
                output.carItems(items: carItems)
            }
    }
}
