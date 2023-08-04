//
//  CarsInteractor.swift
//  Avtomobilka
//
//  Created by v.vaskin on 25/07/2023.
//

class CarsInteractor: CarsInteractorInput {
    weak var output: CarsInteractorOutput!

    // MARK: <CarsInteractorInput>
    func carItems(page: Int) {
        NetworkService.shared.cars(page: page) { [weak self] cars in
            guard let self = self else { return }
            output.carItems(items: cars)
        } errorResponse: { error in
            print("Fetch cars list error: \(error.localizedDescription)")
        }
    }
}
