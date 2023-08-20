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
    func carPosts(carId: Int, page: Int) -> AnyPublisher<PostItems, MoyaError>
}

class NetworkAlamofireSession: Alamofire.Session {
    static let sharedSession: NetworkAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return NetworkAlamofireSession(configuration: configuration)
    }()
}

class NetworkService: NetworkRequestable {

    static let shared = NetworkService()
    
    let provider =  MoyaProvider<APIService>(callbackQueue: DispatchQueue.global(qos: .utility), session: NetworkAlamofireSession.sharedSession)
    
    private init() {
        initService()
    }
    
    func initService() {
        print("Init network service")
    }
    
    func request(target: APIService) -> AnyPublisher<Response, MoyaError> {
        provider.requestPublisher(target).filterSuccessfulStatusCodes()
    }
    
    func cars(page: Int) -> AnyPublisher<[CarItem], MoyaError> {
        let target: APIService = .cars(items: 10, page: page)
        return request(target: target).map([CarItem].self)
    }
    
    func card(id: Int) -> AnyPublisher<CardItem, MoyaError> {
        let target: APIService = .car(id: id)
        return request(target: target).map(CardItem.self)
    }
    
    func carPosts(carId: Int, page: Int) -> AnyPublisher<PostItems, MoyaError> {
        let target: APIService = .carPosts(id: carId, items: 10, page: page)
        return request(target: target).map(PostItems.self)
    }
}
