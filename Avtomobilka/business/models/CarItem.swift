//
//  CarItem.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 26.07.2023.
//

import Foundation

struct CarItem: Codable {
    
    struct Image: Codable {
        var url: URL
    }
    
    var id: Int
    var brandName: String
    var modelName: String
    var name: String
    var year: Int
    var image: URL?
    var images: [Image]?
    var firstImage: URL? { images?[0].url }
    var engine: String
    var transmissionName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, year, image, images, engine
        case brandName = "brand_name"
        case modelName = "model_name"
        case transmissionName = "transmission_name"
    }
}
