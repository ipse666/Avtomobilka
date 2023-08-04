//
//  APIService.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 25.07.2023.
//

import Foundation
import Moya

enum APIService {
    case cars(items: Int, page: Int)
    case car(id: Int)
    case carPosts(id: Int, items: Int, page: Int)
}

extension APIService: TargetType {
    var baseURL: URL {
        URL(string: "http://am111.05.testing.place/api/v1/")!
    }
    
    var path: String {
        switch self {
        case .cars:
            return "cars/list"
        case .car(let id):
            return "car/\(id)"
        case .carPosts(let id, _, _):
            return "car/\(id)/posts"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .cars(let items, let page):
            return .requestParameters(parameters: ["items": items, "page": page], encoding: URLEncoding.default)
        case .car:
            return .requestPlain
        case .carPosts( _, let items, let page):
            return .requestParameters(parameters: ["items": items, "page": page], encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
}
