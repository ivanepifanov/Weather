//
//  SearchCityService.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 28/03/2024.
//

import Foundation
import MapKit
import Combine

public final class SearchCityService {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    
    public init() {
    }
    
    public func searchCities(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = .address
        
        let search = MKLocalSearch(request: request)

        search.start { [weak self] response, _ in
            guard let response = response else { return }

            self?.localSearchPublisher.send(response.mapItems)
        }
    }
    
}
