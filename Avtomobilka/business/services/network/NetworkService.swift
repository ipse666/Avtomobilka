//
//  NetworkService.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 26.07.2023.
//

import Foundation
import Alamofire
import Moya

protocol NetworkRequestable {
    
    func cars(page: Int,
              response: @escaping ([CarItem]) -> (),
              errorResponse: @escaping (NetworkError) -> ())
    
    func card(id: Int,
              response: @escaping (CardItem) -> (),
              errorResponse: @escaping (NetworkError) -> ())
    
    func carPosts(carId: Int,
                  page: Int,
                  response: @escaping ([PostItem]) -> (),
                  errorResponse: @escaping (NetworkError) -> ())
}

enum NetworkError: Error {
    case serverConnectionError(_ error: Error)
    case codeError(_ code: Int)
    case mapResponseError(_ error: Error)
    
    var description: String {
        switch self {
        case .serverConnectionError(let error): return "Ошибка соединения с интернетом, \(error.localizedDescription)"
        case .codeError(let code): return "Код ошибки сервера \(code)"
        case .mapResponseError(let error): return "Ошибка разбора ответа сервера, \(error.localizedDescription)"
        }
    }
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

    func request(target: APIService, successResponse: @escaping (Response) -> (), errorResponse: @escaping (NetworkError) -> ()) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    successResponse(filteredResponse)
                } catch let error {
                    if let errorCode = (error as? MoyaError)?.errorCode {
                        errorResponse(NetworkError.codeError(errorCode))
                    }
                }
            case .failure(let error):
                errorResponse(NetworkError.serverConnectionError(error))
            }
        }
    }
    
    func cars(page: Int,
              response: @escaping ([CarItem]) -> (),
              errorResponse: @escaping (NetworkError) -> ()) {
        let target: APIService = .cars(items: 10, page: page)
        request(target: target, successResponse: { successResponse in
            do {
                let carItems = try successResponse.map([CarItem].self)
                response(carItems)
            }
            catch let error {
                errorResponse(NetworkError.mapResponseError(error))
            }
        }, errorResponse: errorResponse)
    }
    
    func card(id: Int,
              response: @escaping (CardItem) -> (),
             errorResponse: @escaping (NetworkError) -> ()) {
        let target: APIService = .car(id: id)
        request(target: target, successResponse: { successResponse in
            do {
                let cardItem = try successResponse.map(CardItem.self)
                response(cardItem)
            }
            catch let error {
                print("Map error \(error)")
                errorResponse(NetworkError.mapResponseError(error))
            }
        }, errorResponse: errorResponse)
    }
    
    func carPosts(carId: Int,
                  page: Int,
                  response: @escaping ([PostItem]) -> (),
                  errorResponse: @escaping (NetworkError) -> ()) {
        let target: APIService = .carPosts(id: carId, items: 10, page: page)
        request(target: target, successResponse: { successResponse in
            do {
                let postItems = try successResponse.map(PostItems.self)
                response(postItems.posts)
            }
            catch let error {
                errorResponse(NetworkError.mapResponseError(error))
            }
        }, errorResponse: errorResponse)
    }
}
