//
//  Decoder.swift
//  
//
//  Created by Asude Nisa Tıraş on 7.01.2024.
//

import Foundation

public enum WeatherDecoders {
   public static let weatherDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    public static let dateFormatter : DateFormatter =  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    } ()
}
