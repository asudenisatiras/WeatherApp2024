//
//  Date+Extension.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 10.01.2024.
//

import Foundation

extension Date {
    func toString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
       return dateFormatter.string(from: self)
    }
}
