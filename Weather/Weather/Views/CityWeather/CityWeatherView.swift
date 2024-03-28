//
//  CityWeatherView.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 28/03/2024.
//

import SwiftUI
import CoreLocation

struct CityWeatherView: View {
    
    @StateObject private var viewModel: CityWeatherViewModel
    
    init(city: City) {
        _viewModel = StateObject(wrappedValue: CityWeatherViewModel(city: city))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
        }
        .padding(.horizontal)
        .padding(.top)
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle(viewModel.city.title)
    }
}

#Preview {
    let city = City(title: "New York",
                    coordinate: CLLocationCoordinate2D(latitude: 40.730610,
                                                       longitude: -73.935242))
    return CityWeatherView(city: city)
}
