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
    private var page = 1
    private var recentCarsCount = 0

    // MARK: <CarsInteractorInput>
    func carItems() {
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
                recentCarsCount = carItems.count
                output.carItems(items: carItems)
            }
    }
    
    func nextCarItems() {
        if recentCarsCount == Constants.Page.itemsCount {
            page += 1
            carItems()
        }
    }
}
