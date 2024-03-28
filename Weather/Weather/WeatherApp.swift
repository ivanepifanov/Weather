//
//  WeatherApp.swift
//  Weather
//
//  Created by Ivan Yepiphanov on 27/03/2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CitySelectionView().navigationTitle("Select City")
            }
        }
    }
}
