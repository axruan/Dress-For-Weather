//
//  WeatherView.swift
//
/// This view displays two tabs: outfit suggestions and forecast
///
import SwiftUI
import MapKit

struct ForeCastView: View {
    let coordinate: CLLocationCoordinate2D
    @ObservedObject var viewModel = WeatherViewModel.shared
    
    var body: some View {
        TabView {
            WeeklyOutfitView(coordinate: coordinate)
                .tabItem {
                    Label("Outfit", systemImage: "calendar")
                }
            
            WeeklyWeatherView(coordinate: coordinate)
                .tabItem {
                    Label("Weather", systemImage: "sun.max")
                }
        }
    }
}

struct ForeCastView_Previews: PreviewProvider {
    static var previews: some View {
        ForeCastView(coordinate:CLLocationCoordinate2D(latitude: 42.655251, longitude: -71.139671))
    }
}
