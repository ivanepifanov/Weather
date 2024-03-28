//
//  CitySelectionView.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 27/03/2024.
//

import SwiftUI

struct CitySelectionView: View {
    
    @StateObject private var viewModel = CitySelectionViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search", text: $viewModel.cityNameQuery)
            Divider()
            List(viewModel.citiesList, id:\.self.id) { city in
                NavigationLink(city.title) {
                    CityWeatherView(city: city)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    CitySelectionView()
}
