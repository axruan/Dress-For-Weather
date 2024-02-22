//
//  WeeklyWeatherView.swift
//
/// This view functions almost identical to the WeeklyOutfitView, except it shows forecast instead of outfit suggestions.
///
import SwiftUI
import MapKit

struct WeeklyWeatherView: View {
    let coordinate: CLLocationCoordinate2D
    @ObservedObject var viewModel = WeatherViewModel.shared
    
    var body: some View {

            TabView {
                ForEach((0...4), id: \.self) {
                    if (viewModel.isLoading) {
                        DailyWeatherView(index: Int($0))
                            .redacted(reason: .privacy) 
                    } else {
                        DailyWeatherView(index: Int($0))
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onAppear{
                viewModel.getFiveDayWeatherFromCoordinate(coordinate: coordinate)
            }
            .alert(isPresented: $viewModel.showingWeatherAlert) {
                Alert(title: Text("Service is temporarily down."),
                      message: Text("Please try again later"),
                      dismissButton: .default(Text("OK")))
            }
    }
}

struct WeeklyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyWeatherView(coordinate:CLLocationCoordinate2D(latitude: 42.655251, longitude: -71.139671))
    }
}
