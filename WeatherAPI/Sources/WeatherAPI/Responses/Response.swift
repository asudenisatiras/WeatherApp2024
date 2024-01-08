//
//  Response.swift
//
//
//  Created by Asude Nisa Tıraş on 7.01.2024.
//

import Foundation

public struct Response: Decodable {
    public let results: [WeatherData]
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([WeatherData].self, forKey: .results)
    }
}
