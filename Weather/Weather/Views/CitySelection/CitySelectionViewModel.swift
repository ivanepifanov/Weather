//
//  CitySelectionViewModel.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 28/03/2024.
//

import Foundation
import MapKit
import Combine

final class CitySelectionViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    lazy var searchCityService = SearchCityService()
    
    @Published var cityNameQuery = "" {
        didSet {
            searchCityService.searchCities(query: cityNameQuery)
        }
    }

    @Published var citiesList = [City]()
    
    init() {
        cancellable = searchCityService.localSearchPublisher.sink { mapItems in
            self.citiesList = mapItems.map({ City(mapItem: $0) })
        }
    }
}
