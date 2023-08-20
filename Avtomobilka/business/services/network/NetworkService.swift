//
//  NetworkService.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 26.07.2023.
//

import Foundation
import Alamofire
import Moya
import Combine
import CombineMoya

protocol NetworkRequestable {
    func cars(page: Int) -> AnyPublisher<[CarItem], MoyaError>
    func card(id: Int) -> AnyPublisher<CardItem, MoyaError>
    func carPosts(carId: Int, page: Int) -> AnyPublisher<[PostItem], MoyaError>
}

class NetworkService: NetworkRequestable {

    static let shared = NetworkService()
    
    let provider =  MoyaProvider<APIService>()
    
    private init() {}
    
    func request(target: APIService) -> AnyPublisher<Response, MoyaError> {
        provider.requestPublisher(target).filterSuccessfulStatusCodes()
    }
    
    func cars(page: Int) -> AnyPublisher<[CarItem], MoyaError> {
        let target: APIService = .cars(items: Constants.Page.itemsCount, page: page)
        return request(target: target).map([CarItem].self)
    }
    
    func card(id: Int) -> AnyPublisher<CardItem, MoyaError> {
        let target: APIService = .car(id: id)
        return request(target: target).map(CardItem.self)
    }
    
    func carPosts(carId: Int, page: Int) -> AnyPublisher<[PostItem], MoyaError> {
        let target: APIService = .carPosts(id: carId, items: Constants.Page.itemsCount, page: page)
        return request(target: target)
            .map(PostItems.self)
            .map{$0.posts}
            .eraseToAnyPublisher()
    }
}
