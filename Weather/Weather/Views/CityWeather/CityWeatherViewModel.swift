//
//  CityWeatherViewModel.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 28/03/2024.
//

import Foundation

final class CityWeatherViewModel: ObservableObject {
    var city: City
    
    init(city: City) {
        self.city = city
    }
}
